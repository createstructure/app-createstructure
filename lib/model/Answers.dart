/**
  * Manager for the answers given by the user.
  *
  * @author @DavideC03
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Answers {
  String _name = "";
  String _template = "";
  String _descr = "";
  String _prefix = "";
  String _org = "";
  String _team = "";
  bool _private = false;
  bool _isOrg = false;
  BuildContext? _context;

  Answers() {}

  void change(String key, String value) {
    /**
      * Change the value of the key.
      *
      * @param key The key to change.
      * @param value The new value.
      */
    switch (key) {
      case "name":
        name = value;
        break;
      case "template":
        template = value;
        break;
      case "descr":
      case "description":
        descr = value;
        break;
      case "prefix":
        prefix = value;
        break;
      case "org":
        org = value;
        isOrg = value != "";
        break;
      case "private":
        private = !(["N", "No", "n", "no"].contains(value)) || value == "";
        break;
      case "isOrg":
        isOrg = value;
        break;
      case "team":
        team = value;
        break;
    }
  }

  get isOrg => _isOrg;

  set isOrg(value) {
    _isOrg = value;
  }

  bool get private => _private;

  set private(bool value) {
    _private = value;
  }

  get org => _org;

  set org(value) {
    _org = value;
  }

  get prefix => _prefix;

  set prefix(value) {
    _prefix = value;
  }

  get descr => _descr;

  set descr(value) {
    _descr = value;
  }

  get template => _template;

  set template(value) {
    _template = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  get team => _team;

  set team(value) {
    _team = value;
  }

  set context(BuildContext value) {
    _context = value;
  }

  @override
  String toString() {
    /**
      * Return a string representation of the object.
      *
      * @return A string representation of the object.
      */
    return AppLocalizations.of(_context!)!.summary +
        "\n\t\t\t\t\t\t\t\t" +
        AppLocalizations.of(_context!)!.repo_name +
        (name == "" ? "<empty>" : name) +
        "\n\t\t\t\t\t\t\t\t" +
        AppLocalizations.of(_context!)!.repo_template +
        (template == "" ? "<empty>" : template) +
        "\n\t\t\t\t\t\t\t\t" +
        AppLocalizations.of(_context!)!.repo_descr +
        (descr == "" ? "<empty>" : descr) +
        "\n\t\t\t\t\t\t\t\t" +
        AppLocalizations.of(_context!)!.repo_prefix +
        (prefix == "" ? "<empty>" : prefix) +
        "\n\t\t\t\t\t\t\t\t" +
        AppLocalizations.of(_context!)!.repo_org +
        (org == "" ? "<empty>" : org) +
        "\n\t\t\t\t\t\t\t\t" +
        AppLocalizations.of(_context!)!.repo_team +
        (team == "" ? "<empty>" : team) +
        "\n\t\t\t\t\t\t\t\t" +
        AppLocalizations.of(_context!)!.repo_private +
        (private
            ? AppLocalizations.of(_context!)!.true_
            : AppLocalizations.of(_context!)!.false_);
  }
}
