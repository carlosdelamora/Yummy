# Yummy

---

## Steps to Run the App

1. **Open the Project**:
   - Navigate to the cloned directory.
   - Open the `.xcodeproj` or `.xcworkspace` file in **Xcode 16**.

2. **Install Dependencies**:
   - If the project uses external dependencies (e.g., SPM), Xcode should automatically resolve them when you open the project.

3. **Run the App**:
   - Select a simulator or connected device.
   - Press `Cmd + R` or click the **Run** button in Xcode to build and launch the app.

---

## Focus Areas

I focused on the following areas to ensure the project demonstrates best practices:

### Architecture
- Emphasized the use of **SOLID principles**, modularization, and the **MVVM pattern**.
- Modularization was achieved by creating a dedicated package for better scalability and code organization.

### Dependency Injection
- Utilized the **Factory library** to manage dependencies, enabling easy testing by mocking objects.
- This approach ensures components are isolated and testable.

---

## Time Spent

- Total time spent on the project: **5 hours and 20 minutes**, including:
  - **Development**: Writing core functionality.
  - **Unit Testing**: Testing ViewModels to ensure correctness.
  - **Performance Analysis**: Running **Instruments** to check the app's performance.

---

## Trade-offs and Decisions

### Testing
- Only the **ViewModel** was tested. Ideally, other components should also have been covered with tests.

### Loading State Management
- The **ViewModel** handles all loading states. While functional for this project, a dedicated **loading state machine** would better handle state transitions in larger projects.

### SwiftUI Previews
- SwiftUI previews currently call the network directly. Providing mocks for previews would have been preferable to ensure better preview performance and isolation.

---

## Weakest Part of the Project

### Lack of Reusable UI Components
- No reusable UI elements (e.g., **ViewModifiers**, font styles, color palettes) were created since they were not explicitly required.
- This limits the opportunity to showcase UI customization and reusability.

---

## External Code and Dependencies

- **Factory**: Used for dependency injection, ensuring testability and clean architecture.
- **ChatGPT**: Assisted in drafting the **CacheImage** component and its documentation.

---

## Additional Information

- The app is built using **Swift 6** with structured concurrency.
- Chose **ObservableObject** over the `@Observable` macro to maintain compatibility with **iOS 16**, as it aligns with the requirements for the Fetch app. 
