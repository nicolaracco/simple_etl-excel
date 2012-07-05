require 'spec_helper'

module SimpleEtl
  module Excel
    describe Parser do
      describe '#fetch_field_from_row' do
        it 'fetches the field using the :at attribute' do
          subject.fetch_field_from_row(['a','b','c'], :at => 2).should == 'c'
        end

        context 'when the value is a formula' do
          it 'returns the value of the formula' do
            f = Spreadsheet::Formula.new
            f.value = 'foo'
            subject.fetch_field_from_row([f], :at => 0).should == 'foo'
          end
        end
      end

      describe '#read_rows' do
        context 'when :type is inline' do
          it 'treats the argument as a Spreadsheet object' do
            s = double
            s.should_receive :worksheet
            subject.read_rows s, :type => :inline
          end
        end

        context 'when :type is not inline' do
          it 'opens the file with spreadsheet' do
            s = double
            s.should_receive :worksheet
            Spreadsheet.should_receive(:open).with('foo').and_return s
            subject.read_rows 'foo'
          end
        end

        context 'when the sheet is valid' do
          it 'returns the rows' do
            s = double
            s.stub :worksheet do
              h = double
              h.stub(:each) { |&block| block.call ['a'] }
              h
            end
            subject.read_rows(s, :type => :inline).should == [['a']]
          end
        end

        context 'when the sheet is void' do
          it 'returns empty array by default' do
            s = double
            s.stub :worksheet => nil
            subject.read_rows(s, :type => :inline).should == []
          end

          it 'raises error if requested on context' do
            subject.context.raise_error_on_void_sheet
            s = double
            s.stub :worksheet => nil
            expect {
              subject.read_rows s, :type => :inline
            }.to raise_error VoidSheetError
          end
        end
      end

      it 'socks at brush' do
        s = SimpleEtl::Source.load File.join FIXTURES_PATH, 'acme_coffin_company.stl'
        result = s.parse File.join FIXTURES_PATH, 'acme_coffin_company.xls'
        result.should be_valid
        result.rows.count.should == 7
        result.rows.first.attributes.should == {
          :name      => "Frankenstein",
          :rate      => 14.0,
          :ot_rate   => nil,
          :reg_hours => 40.0,
          :ot_hours  => 5.0,
          :reg_pay   => 560.0,
          :ot_pay    => 70.0,
          :total_pay => 630.0,
          :tax_rate  => 0.125,
          :taxes     => nil,
          :net_pay   => nil
        }
      end
    end
  end
end