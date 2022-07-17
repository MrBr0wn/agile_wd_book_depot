class Product < ApplicationRecord
	has_many :line_items
	has_many :orders, through: :line_items

	before_destroy :ensure_not_referenced_by_any_line_items

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :title, uniqueness: true, length: { minimum: 5, too_short: "%{count} characters is the minimum allowed" }
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|jpeg|png)\z}i,
		message: 'must be a URL for GIF, JPG, JPEG or PNG image.'
	}

	private

		def ensure_not_referenced_by_any_line_items
			unless line_items.empty?
				errors.add(:base, 'Line Items presented')
				throw :abort
			end
		end
end
