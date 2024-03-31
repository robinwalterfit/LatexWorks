module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'scope-enum': [
      2,
      'always',
      [
        'actions',
        'CONTRIBUTING',
        'docker',
        'editor',
        'git',
        'linter',
        'README',
        'vscode'
      ]
    ]
  }
}
