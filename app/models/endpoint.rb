# frozen_string_literal: true

# Endpoint manages API URL's for a project
class Endpoint < ApplicationRecord
  belongs_to :user
  belongs_to :project

  has_many :requests, dependent: :destroy

  before_validation :strip_whitespace

  before_save :update_lookup_hash

  validate :route_is_unique
  validate :validate_response_headers
  validate :validate_request_path
  validates :request_path, presence: true, length: { minimum: 1, maximum: 255 }
  validates :request_method,
            inclusion: { in: %w[GET POST PUT PATCH DELETE ANY],
                         message: I18n.t('models.endpoint.invalid_request_method') }
  validates :response_status_code, numericality: { only_integer: true, greater_than_or_equal_to: 100, less_than: 600 }
  validates :delay_in_milliseconds,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 10_000 }, allow_blank: true

  def url
    "https://#{project.subdomain}.httpmock.dev#{request_path}"
  end

  private

  def validate_response_headers
    return if response_headers.blank?

    begin
      headers = []
      JSON.parse(response_headers).each do |header|
        headers.push({ header.keys[0] => header[header.keys[0]] })
      end
      self.response_headers = JSON.serialize(headers)
    rescue JSON::ParserError => _e
      errors.add(:response_headers, I18n.t('models.endpoint.invalid_response_headers'))
    end
  end

  def route_is_unique
    endpoint = Endpoint.where(lookup_hash: build_lookup_hash).where.not(id:).first
    return if endpoint.blank?

    route = "#{endpoint.request_method} #{endpoint.request_path}"
    errors.add(
      :request_path,
      I18n.t('models.endpoint.request_path_already_exists', route:)
    )
  end

  def build_lookup_hash
    if request_method != 'ANY'
      return %W[{#{project.subdomain}}{#{request_method}}{#{request_path}} {#{project.subdomain}}{ANY}{#{request_path}}]
    end

    hashes = []
    %w[GET POST PUT PATCH DELETE].each do |method|
      hashes.push("{#{project.subdomain}}{#{method}}{#{request_path}}")
    end
    hashes
  end

  def update_lookup_hash
    self.lookup_hash = "{#{project.subdomain}}{#{request_method}}{#{request_path}}"
  end

  def validate_request_path
    return if URI::DEFAULT_PARSER.make_regexp.match("https://httpmock.dev#{request_path}")

    errors.add(:request_path, I18n.t('models.endpoint.invalid_request_path'))
  end

  # rubocop:disable Metrics/AbcSize
  def strip_whitespace
    self.request_path = request_path.strip
    self.response_headers = response_headers.strip
    self.response_body = response_body.strip
    self.description = description.strip

    self.request_path = "/#{request_path}" if request_path.present? && request_path[0] != '/'
  end
  # rubocop:enable all
end
