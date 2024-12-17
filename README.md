# hedieaty_app_

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## TODOs

1. **Authentication**:
    - Build and test the Authentication feature.
2. **Database**:
    - Design and implement database tables.
    - Test CRUD operations.
3. **Milestone 1**:
    - Review and refine the completed tasks for Milestone 1.

---

### Explanation of Providers

#### 1. EventRemoteRepository
- Manages interaction with the remote data source (e.g., Firestore, API).
- Provides dependencies for `DomainEventRepository`.

#### 2. DomainEventRepository
- Implements application-specific business logic while using `EventRemoteRepository` for data access.
- ProxyProvider automatically injects the necessary dependencies.

---

### Notes
- Static routes are defined in `appRoutes`.
- Dynamic routing uses `AppRouter.generateRoute` for routes with parameters.
