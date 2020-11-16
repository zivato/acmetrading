# acmetrading

1. Create new project
2. Indlude tests
3. Lifecycle UIKit
4. Constants file for API urls
5. Struct Constants / API
6. Download logo add to assets
7. ACME logo 200px x 200px - Use at a maximum of 100px x 100px to prevent pixelation at 2x
8. Get colours and rough positions from screen design PNG
9. Plan out ViewControllers needed
10. Create LoginVC and ProfileListVC
11. Assign LoginVC to initial ViewController
12. Drag in new ViewController
13. Assign ProfileListVC to newly create ViewController
14. Build interface based on screen designs
15. Add all outlets and actions
16. Create post request method for login, including adding parameters "username:" and "password:"
17. Add auth_token and refresh_token to Constants
18. Check http url response status > if == 200 get auth_token and refresh_token and apply to Constants variables
19. Check data structure > step into json data at correct level to parse json response
20. Write method to show success/error message. Change error background colour based on error or success
21. UI tweaks to login, set inset left padding on textfield, round buttons and views to match screen design
22. Open ProfilesListVC, add tableView, create custom cell class
23. Create GET httprequest passing in AUTH_TOKEN as an Authentication header
24. Create ProfileListItem object class
25. In ProfileListVC create array of [ProfileListItem]
26. Write code for tableView, pass applicable values to UI components
27. Write code to pull in image data, sync loaded indexes to prevent images reloading on scroll. Smoother scrolling
28. Write stars function
29. Create TOP RATED cell as per screen designs
30. Adjust row height for indexPath.row '0'
31. Add alertView with action to ProfileListVC if error occurs
32. Create new unit test and LoginValidator class
33. Refactor LoginVC code to include LoginValidator
