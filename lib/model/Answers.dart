class Answers {
  String _name, _template, _descr, _prefix, _org, _team;
  bool _private, _isOrg = false;

  Answers() {
    _name = _template = _descr = _prefix = _org = _team = "";
    _private = _isOrg = false;
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
}
