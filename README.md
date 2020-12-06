# Cost of Care

## Goal

Recent changes in Medicare’s payment policies under the inpatient prospective payment system (PPS) and the long-term care hospital PPS required that the CDM be made available in a machine-readable format by January 1, 2019 . These formats are in XML or CSV and while machine readable do not make sense for a patient who is comparing the prices

The Goal of this Cost Of Care Project is to provide patient friendly costs of care, to help patients get better cost estimates for medical procedures of US Hospitals. User can view the chargemaster, search for a particular procedure in multiple hospitals chargemasters & can sort data by Category or sort by price in ascending or descending order. App downloads hospitals chargemaster from GitLab Repository and save it to local storage of phone in SQL database. Users can also compare hospitals based on ratings & patients experience to get idea about hospital services. This App can work offline and updates data once in a month.


## Communication

The Cost Of Care chat channel is on [Librehealth Forums.](https://forums.librehealth.io/t/project-develop-an-android-mobile-application-to-show-patient-friendly-costs-of-care/3685/103)

## Screenshots

|  |  | |
| ------ | ------ | ------ |
| <img src="/screenshots/home.png" align="top">| <img src="/screenshots/settings.png" align="top"> |  <img src="/screenshots/search_procedure.png" align="top"> |
| Home screen displaying nearby hospitals & user location |  Settings screen to filter nearby hospitals & change location |   Search screen - Searching by procedure |
|   <img src="/screenshots/search_price.png" align="top">| <img src="/screenshots/filter.png" align="top"> |  <img src="/screenshots/drawer.png" align="top"> |
|   Search screen - Searching by price |    Bottom sheet to filter searching in CDM |     Navigation drawer - Navigate to different app screens.   |
|   <img src="/screenshots/compare.png" align="top">| <img src="/screenshots/compare_screen.png" align="top"> |<img src="/screenshots/compare_screen_detail.png" align="top"> |
|  Choose any two hospitals to compare them |  Compare screen - Comparing general information |  Compare screen - Comparing patient experience |
| <img src="/screenshots/download_cdm.png" align="top">| <img src="/screenshots/view_cdm.png" align="top"> |  <img src="/screenshots/view_cdm_statewise.png" align="top"> |
| Download CDM - Download ChargeMaster of your nearby hospitals |   View CDM - Viewing individual CDM with search functionality. |     View CDM Statewise - View CDM of other states of US. |
| <img src="/screenshots/saved_cdm.png" align="top">| <img src="/screenshots/about.png" align="top"> |
|  Saved ChargeMasters - CDMs Saved in SQL database of app |  About us page of the project in the app.  |


## Dependencies

- cupertino_icons: ^0.1.3
- html: ^0.14.0+3
- shimmer: ^1.1.1
- geolocator: ^5.3.2+2
- location: ^3.0.0
- bloc: ^6.0.1
- flutter_bloc: ^6.0.1
- equatable: ^1.2.0
- cached_network_image: ^2.2.0+1
- file_utils: ^0.1.4
- hive: ^1.4.1+1
- hive_flutter: ^0.3.0+2
- path_provider: ^1.6.5
- dio: ^3.0.9
- permission_handler: ^5.0.0+hotfix.5
- flutter_cache_manager: ^1.4.1
- share: ^0.6.4+3
- url_launcher: ^5.5.0



## Branch Policy

We have the following branches

* **development**  All development goes on in this branch. If you're contributing, you are supposed to make a merge request to development. PRs to development branch must pass a build check and a unit-test check on Gitlab pipeline.

* **master** This contains shipped code. After significant features/bugfixes are accumulated on development, we make a version update and make a release.

## Maintainers and Developers

* [**Mua N. Laurent**](https://gitlab.com/muarachmann)

* [**Darshpreet Singh**](https://gitlab.com/Darshpreet2000)

* [**Judy Gichoya**](https://gitlab.com/judywawira)

* [**Saptarshi Purkayastha**](https://gitlab.com/sunbiz)

* [**Robby O Connor**](https://gitlab.com/robbyoconnor)


## Contributions Best Practices

Please help us follow the best practice to make it easy for the reviewer as well as the contributor. We want to focus on the code quality more than on managing pull request ethics.

* Single commit per pull request
* Reference the issue numbers in the commit message. Follow the pattern ``` Fixes #<issue number> <commit message>```
* Follow uniform design practices. The design language must be consistent throughout the app.
* The pull request will not get merged until and unless the commits are squashed. In case there are multiple commits on the PR, the commit author needs to squash them and not the maintainers cherrypicking and merging squashes.
* If the PR is related to any front end change, please attach relevant screenshots in the pull request description.
* Before you join development, please set up the project on your local machine, run it and go through the application completely. Press on any button you can find and see where it leads to. Explore.
* If you would like to work on an issue, drop in a comment at the issue. If it is already assigned to someone, but there is no sign of any work being done, please free to start working on it.


## License

This project is licensed under the Mozilla Public License 2.0 with Healthcare Disclaimer. a copy of this license can be found in `LICENSE`.
