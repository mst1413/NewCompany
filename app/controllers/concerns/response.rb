module Response

    def collection_serializer( data , serializer )
        ActiveModel::Serializer::CollectionSerializer.new( data , serializer: serializer )
    end

end