# frozen_string_literal: true

module Spree
  class ProductProperty < ActiveRecord::Base
    belongs_to :product, class_name: "Spree::Product", touch: true
    belongs_to :property, class_name: 'Spree::Property'

    validates :property, presence: true
    validates :value, length: { maximum: 255 }

    default_scope -> { order("#{table_name}.position") }

    # virtual attributes for use with AJAX completion stuff
    def property_name
      property&.name
    end

    def property_name=(name)
      if name.present?
        unless property = Property.find_by(name: name)
          property = Property.create(name: name, presentation: name)
        end
        self.property = property
      end
    end
  end
end
