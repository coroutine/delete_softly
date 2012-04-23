module DeleteSoftly
  module ClassMethods

    # Same as active, but not to be overwritten. Active might become with disabled => false
    # or something like that. Without deleted should remain intact
    def without_deleted
      where(:deleted_at => nil)
    end

    # Include deleted items when performing queries
    #   class Item < ActiveRecord::Base
    #     default_scope order(:content)
    #     delete_softly
    #   end
    # Will result in:
    #   Item.first #=> SELECT "items".* FROM "items" WHERE ("items"."deleted_at" IS NULL) ORDER BY "items"."content" LIMIT 1
    #   Item.with_deleted.first #=> SELECT "items".* FROM "items" ORDER BY "items"."content" LIMIT 1
    #   Item.where(:content.matches => 'a%') #=> SELECT "items".* FROM "items" WHERE ("items"."deleted_at" IS NULL) AND ("items"."content" ILIKE 'a%') ORDER BY "items"."content"
    #   Item.with_deleted do
    #     Item.where(:content.matches => 'a%') #=> SELECT "items".* FROM "items" WHERE ("items"."content" ILIKE 'a%') ORDER BY "items"."content"
    #   end
    #   IHaveManyItems.first.items #=> SELECT "items".* FROM "items" WHERE ("items"."deleted_at" IS NULL) AND ("items".i_have_many_items_id = 1) ORDER BY "items"."content"
    #   IHaveManyItems.first.items.with_deleted #=> SELECT "items".* FROM "items" WHERE ("items".i_have_many_items_id = 1) ORDER BY "items"."content"
    # For rails 3.2 method is being commented out as it uses private methods that have been removed from the 3.2. To achieve the same behavior, unscoped method should be used.
    #def with_deleted(&block)
    #  if scoped_methods.any? # There are scoped methods in place
    #
    #    # remove deleted at condition if present
    #    del = scoped_methods.last.where_values.delete(:deleted_at => nil)
    #
    #    # Execute block with deleted or just run scoped
    #    r = block_given? ? yield : scoped
    #
    #    # Add deleted condition if it was present
    #    scoped_methods.last.where_values << del if del
    #
    #    # Return de relation generated without deleted_at => nil
    #    r
    #  else
    #    # Do not do anything special when there are no scoped_methods
    #    r = block_given? ? yield : scoped
    #  end
    #end

    def deleted
      with_deleted.where("deleted_at is not null")
    end
  end

end
