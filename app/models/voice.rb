class Voice < ApplicationRecord
  enum style: %i[author editor translator]

  belongs_to :author
  validates_presence_of :author

  belongs_to :work
  validates_presence_of :work

  accepts_nested_attributes_for :author
  
  def birth=(date)
    super(date_unsplitter(date))
  end

  def death=(date)
    super(date_unsplitter(date))
  end


  def voice_attributes=(array)
    array.each do |author|
      voice.build(author)
    end
  end

  def author_attributes=(hash)
    self.author = Author.find_or_initialize_by(hash)
  end
end
