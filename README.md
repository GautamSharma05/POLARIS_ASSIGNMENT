# Polaris

A smart metering Flutter project.

## Overview

The Smart Metering Flutter project is a modern solution for utility companies and consumers alike to efficiently manage energy consumption. This innovative app leverages Flutter technology to provide a seamless user experience across multiple platforms, including Android and iOS.

## Installation

### Prerequisites

- Flutter SDK installed ([Installation instructions](https://flutter.dev/docs/get-started/install))

### Steps to run the project

1. Clone the repository:

   ```bash
   https://github.com/GautamSharma05/POLARIS_ASSIGNMENT/tree/main

2. Change Directory:

   ```bash
   cd POLARIS_ASSIGNMENT

3. Get Packages:

   ```bash
   flutter pub get 

4. Run App:

   ```bash
   flutter run

### Components used in application

The Polaris project consists of five main components, each serving a specific function within the application. These components are dynamically loaded onto the form page based on JSON data retrieved from a remote server.

1. **EditTextFormField:** Allows users to input text data into the form.
2. **CheckBoxesFormField:** Provides a list of options for users to select multiple choices.
3. **DropDownFormField:** Presents a dropdown menu for users to choose a single option from a list.
4. **RadioGroupFormField:** Displays a group of radio buttons for users to select a single option.
5. **CaptureImagesFormField:** Enables users to capture and upload images directly within the form.


These components are essential for collecting various types of data from users and facilitating seamless interaction with the app's features. By dynamically loading them based on JSON configuration, the app ensures flexibility and scalability in accommodating different form structures and requirements.

### Validation

The Polaris project implements comprehensive form validation to ensure data integrity and accuracy. This validation process is applied to all form fields dynamically loaded based on JSON data fetched from a remote server. Here's an overview of the validation process:

1. **EditTextFormField Validation:**
Ensures that text fields are not left empty. If the user attempts to submit the form with empty text fields marked as mandatory, an error message prompts them to fill in the required information.
2. **CheckBoxesFormField Validation:**
Verifies that at least one option is selected from the list of checkboxes. If no option is selected for a mandatory checkbox field, the form submission is prevented, and the user is prompted to select at least one option.
3. **DropDownFormField Validation:**
Validates that a selection is made from the dropdown menu. If the dropdown field is marked as mandatory and no option is selected, the form submission is halted, and the user is prompted to choose an option from the list.
4. **RadioGroupFormField Validation:**
Confirms that a single option is selected from the group of radio buttons. If the radio group field is mandatory and no option is selected, the submission is blocked, and the user is reminded to choose a single option.
5. **CaptureImagesFormField Validation:**
Verifies that at least one image is captured and uploaded. If the field requires an image capture and no image is uploaded, the form submission is prohibited, and the user is instructed to capture and upload at least one image.

By implementing these validation checks, the Polaris project ensures that all form submissions contain accurate and complete data, enhancing the overall reliability and usability of the application.


   
