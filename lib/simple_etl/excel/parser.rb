require 'spreadsheet'

module SimpleEtl
  module Excel
    class Parser < SimpleEtl::Source::Base
      def initialize &block
        super Context.new, &block
      end

      def fetch_field_from_row row, field
        value = row[field[:at]]
        value.respond_to?(:value) && value.value || value
      end

      def read_rows src, args = {}
        file = args[:type] == :inline && src || Spreadsheet.open(src)
        sheet = file.worksheet context.sheet_index
        rows = []
        if sheet
          sheet.each { |row| rows << row }
        elsif context.error_on_void_sheet
          raise VoidSheetError
        end
        rows
      end
    end

    SimpleEtl::Source.formats[:excel] = Parser
  end
end