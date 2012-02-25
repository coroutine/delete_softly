module DeleteSoftly
  module InstanceMethods

    # This method reports whether or not the record has been soft deleted.
    #
    def deleted?
      self.deleted_at?
    end
    
    # Custom destroy method for models using delete_softly
    def destroy 
      if persisted?
        with_transaction_returning_status do
          _run_destroy_callbacks do
            update_attribute :deleted_at, Time.now
          end
        end
      end
    
      @destroyed = true
      freeze
    end
      
  end
end
