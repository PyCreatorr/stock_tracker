class Friendship < ApplicationRecord
  # automatically generated
  belongs_to :user

  # Self referential association. Point to itself. Manually generated.
  # we've added manually. Class friend doesnt exist, instead use class User again. 
  belongs_to :friend, class_name: 'User'
end