class CreateOrImportArgs {
  final bool isImport;
  final String? mnemonic;

  CreateOrImportArgs({this.mnemonic, this.isImport = false});
}
