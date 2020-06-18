# frozen_string_literal: true

require "rails_helper"

# Holds specs for code contained in TabularImport (parent class).
describe TabularImport do
  # Fake child class.
  class Foo < TabularImport
    protected

    def process_data
      sheet.row(1) # Need to actually access some data to trip some errors.
    end
  end

  let(:file) { tabular_import_fixture(filename) }
  let(:import) { Foo.new(file: file).tap(&:run) }
  let(:run_errors) { import.run_errors }

  context "with invalid file type" do
    let(:filename) { "not_tabular.jpg" }

    it "should correctly report error" do
      expect(import).not_to be_succeeded
      expect(run_errors).to eq(["The uploaded file must be a valid XLSX-type Excel file."])
    end
  end

  context "with invalid CSV" do
    let(:filename) { "bad.csv" }

    it "should correctly report error" do
      expect(import).not_to be_succeeded
      expect(run_errors).to eq(["There was an issue with your CSV file: Unclosed quoted field in line 1."])
    end
  end

  context "with older XLS file" do
    let(:filename) { "old_format.xls" }

    it "should correctly report error" do
      expect(import).not_to be_succeeded
      expect(run_errors).to eq(["The uploaded file must be a valid XLSX-type Excel file."])
    end
  end
end
