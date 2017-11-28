class Event < ApplicationRecord

  scope :future, -> { where("date >= :current_date",
                            current_date: DateTime.now) }
  scope :past, -> { where("date < :current_date",
                            current_date: DateTime.now) }


  belongs_to :creator, class_name: "User",
                       foreign_key: "user_id"
  has_and_belongs_to_many :attendees, 
                          class_name: "User",
                          foreign_key: "user_id",
                          association_foreign_key: 'event_id'

end
