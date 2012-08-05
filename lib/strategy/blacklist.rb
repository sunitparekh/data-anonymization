module DataAnon
  module Strategy
    class Blacklist < Whitelist

      def process
        source = Utils::SourceTable.create @name, @primary_key
        logger.debug "Processing table #{@name} with fields strategy using #{@fields}"
        progress_logger.info "Table: #{@name} "
        source.all.each do |record|
          progress_logger.info "."
        end
        progress_logger.info " DONE\n"
      end
    end
  end
end
