class Art < ActiveRecord::Base
  attr_accessible :artist, :comment, :title, :location_attributes, :image

  has_one :location
  validates_associated :location
  accepts_nested_attributes_for :location

  has_attached_file :image, storage: :s3, styles: { medium: "300x300>", thumb: "100x100>" }

  validates :location, presence: true

  def to_map_art
    {
      artist: artist,
      title: title,
      lat: location.latitude,
      long: location.longitude,
      image: image.url,
    }
  end

end
