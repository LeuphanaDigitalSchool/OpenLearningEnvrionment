# frozen_string_literal: true
# RegulationSerializer
class RegulationSerializer < ActiveModel::Serializer
  attributes :name, :file

  def regulations
    object.collect do |regulation|
      {
        id: regulation.id,
        name: regulation.name,
        file: regulation.file
      }
    end
  end
end
