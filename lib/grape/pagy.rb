require 'grape'
require 'pagy'
require 'pagy/extras/arel'
require 'pagy/extras/array'
require 'pagy/extras/countless'
require 'pagy/extras/headers'
require 'pagy/extras/limit'
require 'pagy/extras/overflow'

module Grape
  module Pagy
    Wrapper = Struct.new :request, :params do
      include ::Pagy::Backend

      def paginate(collection, using: nil, **opts, &block)
        using ||= if collection.respond_to?(:arel_table)
                    :arel
                  elsif collection.is_a?(Array)
                    :array
                  end

        method = [:pagy, using].compact.join('_')
        page, scope = send(method, collection, **opts)

        pagy_headers(page).each(&block)
        scope
      end
    end

    module Helpers
      extend Grape::API::Helpers

      params :pagy do |**opts|
        limit = opts.delete(:limit) || ::Pagy::DEFAULT[:limit]
        page = opts.delete(:page) || ::Pagy::DEFAULT[:page]
        page_param = opts[:page_param] || ::Pagy::DEFAULT[:page_param]
        limit_param = opts[:limit_param] || ::Pagy::DEFAULT[:limit_param]
        limit_max = opts[:limit_max] || ::Pagy::DEFAULT[:limit_max]

        @api.route_setting(:pagy_options, opts)
        optional page_param, type: Integer, default: page, desc: 'Page offset to fetch.'
        optional limit_param, type: Integer, default: limit, desc: "Number of items to return per page. Maximum value: #{limit_max}"
      end

      # @param [Array|ActiveRecord::Relation] collection the collection or relation.
      def pagy(collection, **opts)
        defaults = route_setting(:pagy_options) || {}

        Wrapper.new(request, params).paginate(collection, **defaults, **opts) do |key, value|
          header key, value
        end
      end
    end
  end
end
