module SimpleEtl
  module Excel
    class Context < SimpleEtl::Source::BaseContext
      attr_reader :sheet_index, :error_on_void_sheet

      def initialize *args
        super
        @sheet_index = 0
        @error_on_void_sheet = false
      end

      def use_sheet index
        @sheet_index = index
      end

      def raise_error_on_void_sheet
        @error_on_void_sheet = true
      end

      def field name, args = {}
        if args[:at]
          @last_cell_index = args[:at]
        else
          @last_cell_index ||= -1
          args[:at] = @last_cell_index += 1
          # if @last_cell_index is nil, then the first field will have index 0
        end
        super
      end
    end
  end
end