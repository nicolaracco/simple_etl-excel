require 'spec_helper'

module SimpleEtl
  module Excel
    describe Context do
      describe 'cell index' do
        context 'when not specified' do
          it 'is automatically set as :at attribute' do
            subject.field :sample
            subject.fields.first[:at].should == 0
          end

          it 'is incremented for each field' do
            subject.field :sample
            subject.field :foo
            subject.fields.last[:at].should == 1
          end
        end

        context 'when specified' do
          it 'can be setted with the :at attribute' do
            subject.field :sample, :at => 21
            subject.fields.first[:at].should == 21
          end

          it 'is incremented from the last specification' do
            subject.field :sample, :at => 21
            subject.field :foo
            subject.fields.last[:at].should == 22
          end
        end
      end

      describe 'sheet index' do
        it 'by default is 0' do
          subject.sheet_index.should == 0
        end

        it 'can be setted with use_sheet helper' do
          subject.use_sheet 1
          subject.sheet_index.should == 1
        end
      end
    end
  end
end