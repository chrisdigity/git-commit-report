# Git Commit Report
> Combining the power of `git diff --stat` and `git log --graph`

Generate informative commit history reports
 - covering multiple repositories
 - for any length of time
 - at any point in time
 - in various formats

## Installation
Simply clone this repository into the directory containing all the git repositories you wish to include in your report, like so...

```sh
cd C:/directory/containing/repos/
git clone https://github.com/chrisdigity/git-commit-history
```

## Usage
_Note: by default, the script will generate a report on 1 week of commits_

For quick usage (using the default configuration), simply open the repository location and double click on the `generate-report.bat` file.

For advanced usage (using modified configuration), either edit the `generate-report.bat` file directly or execute the file on the command line with any arguments you would use with `git log`.

## Example output
Generated with a simple double-click...

```
Git Commit Report for "chrisdigity@gmail.com"
- generated on 2021-07-28T09:19:19 for "1 week ago" to "2021-07-28"


~mochimap-api (on main branch):  
* 955baea increase heartbeat frequency
* 7b4a04a fix invalid messages appended with event line
* 9485cc4 fix mapping iterator to array
* f090c5b adjust route for /stream and conditions for paramRequired
* 0be4919 fix implementation of event type
* d495936 add event type to event stream log
* 7208f47 fix missing conversion of parameter from Events to Event
* fc22714 move EventStreamer route to dedicated /stream endpoint
src/apiEventStreamer.js | 79 ++++++++++++++++++++++++++-----------------------
src/apiResponder.js     |  1 +
src/apiRouter.js        | 23 +++++++++-----
3 files changed, 59 insertions(+), 44 deletions(-)

~mochimap-www (on dev branch):  
* f8b57da re-activate explorers ledger address/tag details page
* b4117fa remove console logging from Mochimo Activity component
* 48e5ca6 implement navigation menu in header
* 36db74e fix img alt warning in IconButtonLink component
* 5e4c759 fix callback dependency warning in TimePrep component with useCallback
* e852f82 implement complex search results feature
* 606bc6b implement Byte Suffix component for displaying byte values
* 9fd1449 implement Mochimo Suffix component for displaying MCM values
* 416f14d implement Time Preparation component for displaying timestamps
* 934f883 implement Mochimo Activity Feed component under Explorer Search form
src/app/component/ByteSuffix.js                    |  14 +
src/app/component/ExplorerSearchForm.js            |   8 +-
src/app/component/Header.js                        | 195 ++++++++------
src/app/component/IconButtonLink.js                |   2 +-
src/app/component/MCMSuffix.js                     |  27 ++
src/app/component/MochimoActivityFeed.js           | 199 ++++++++++++++
src/app/component/TimePrep.js                      |  40 +++
...ddress.js => explorer-ledger-#type-#address.js} |   0
src/app/explorer.js                                | 290 ++++++++++++++++++++-
src/app/service/mochimap-api.js                    |  20 +-
src/routes.js                                      |  14 +-
11 files changed, 703 insertions(+), 106 deletions(-)
```

## License
Distributed under the MIT license.  
See ``LICENSE`` for more information.

## Contributing
1. Fork it (<https://github.com/chrisdigity/git-commit-report/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
