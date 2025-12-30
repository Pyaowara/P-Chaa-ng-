# API Documentation for Postman Testing

## Base URL

```
http://localhost:8080
```

## Endpoints

#### GET /user/getCurrentUser

Get current authenticated user

- **Auth Required**: Yes (optional - returns null if not auth)
- **Body**: None
- **Response**: User object or null

#### GET /user/getAllUser

Get all users (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**: None
- **Response**: Array of User objects

#### POST /user/updateUserRole

Update user role (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "userId": 2,
  "newRole": "manager"
}
```

- **Allowed roles**: "user", "manager", "owner"
- **Response**: Updated User object

---

### 2. Ingredient Endpoints

#### POST /ingredient/createIngredient

Create new ingredient (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "name": "Tomato",
  "isAvailable": true
}
```

- **Response**: Created Ingredient object

#### GET /ingredient/getAllIngredients

Get all ingredients

- **Auth Required**: No
- **Body**: None
- **Response**: Array of Ingredient objects

#### GET /ingredient/getIngredientById

Get ingredient by ID

- **Auth Required**: No
- **Body**:

```json
{
  "id": 1
}
```

- **Response**: Ingredient object or null

#### POST /ingredient/updateIngredient

Update ingredient (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "id": 1,
  "name": "Fresh Tomato",
  "isAvailable": false
}
```

- **Note**: All fields except `id` are optional
- **Response**: Updated Ingredient object

#### POST /ingredient/deleteIngredient

Delete ingredient (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "id": 1
}
```

- **Note**: Soft deletes if referenced in menu items, hard deletes otherwise
- **Response**: `true`

---

### 3. Menu Item Endpoints

#### POST /menuItem/createMenuItem

Create new menu item with optional image upload (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "name": "Margherita Pizza",
  "basePrice": 12.99,
  "timeToPrepare": 15,
  "customization": [
    {
      "title": "Size",
      "pickOne": true,
      "choices": [
        {
          "name": "Small",
          "price": 0.0,
          "isAvailable": true,
          "ingredientIds": null
        },
        {
          "name": "Large",
          "price": 3.0,
          "isAvailable": true,
          "ingredientIds": null
        }
      ]
    }
  ],
  "isAvailable": true,
  "ingredientIds": [1, 2, 3],
  "imageDataBase64": "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD...",
  "imageFileName": "pizza.jpg",
  "imageContentType": "image/jpeg"
}
```

**Image Upload Parameters (all optional):**

- `imageDataBase64`: Base64-encoded image data (supports data URL format or plain base64)
- `imageFileName`: Original filename for the image
- `imageContentType`: MIME type (defaults to "image/jpeg")

**Notes:**

- Pass ingredient IDs, not full objects. Server fetches and validates ingredients.
- Image upload is integrated into creation - no separate endpoint needed
- Supports data URL format: `data:image/jpeg;base64,/9j/4AAQ...` or plain base64
- **Response**: Created MenuItem object (imageUrl not included in response, computed on GET)

#### GET /menuItem/getAllMenuItems

Get all menu items with image URLs

- **Auth Required**: No
- **Body**: None
- **Response**: Array of MenuItemWithUrl objects with `imageUrl` populated
- **Note**: Each menu item includes `imageUrl` field with direct URL to image

#### GET /menuItem/getMenuItemById

Get menu item by ID with image URL

- **Auth Required**: No
- **Body**:

```json
{
  "id": 1
}
```

- **Response**: MenuItemWithUrl object with `imageUrl` populated or null
- **Note**: Response includes `imageUrl` field with direct URL to image

#### GET /menuItem/getAllAvailableMenuItems

Get all available menu items with forSale status

- **Auth Required**: No
- **Body**: None
- **Response**: Array of AvailableMenuItem objects
- **Note**: Includes `forSale` for menu item and each customization choice, based on availability and ingredient availability

#### GET /menuItem/getAvailableMenuItemById

Get available menu item by ID with forSale status

- **Auth Required**: No
- **Body**:

```json
{
  "id": 1
}
```

- **Response**: AvailableMenuItem object or null
- **Note**: Includes `forSale` for menu item and each customization choice, based on availability and ingredient availability

#### POST /menuItem/updateMenuItem

Update menu item with optional image upload/removal (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "id": 1,
  "name": "Updated Pizza Name",
  "basePrice": 14.99,
  "timeToPrepare": 20,
  "customization": null,
  "isAvailable": false,
  "ingredientIds": [1, 3, 5],
  "removeImage": true,
  "imageDataBase64": "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD...",
  "imageFileName": "updated-pizza.jpg",
  "imageContentType": "image/jpeg"
}
```

**Image Management Parameters (all optional):**

- `removeImage`: Set to `true` to delete existing image
- `imageDataBase64`: Base64-encoded image data for new/replacement image
- `imageFileName`: Filename for the new image
- `imageContentType`: MIME type for the new image

**Notes:**

- All fields except `id` are optional
- Image upload/removal is integrated - no separate endpoint needed
- Setting `removeImage: true` deletes current image
- Providing image parameters uploads new image (replaces existing)
- Pass `ingredientIds` to update ingredients (empty array clears all)
- Supports data URL format or plain base64
- **Response**: Updated MenuItem object (imageUrl not included in response, computed on GET)

#### POST /menuItem/deleteMenuItem

Delete menu item (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "id": 1
}
```

- **Note**: Soft deletes if referenced in orders/carts, hard deletes otherwise
- **Response**: `true`

---

## Common Response Objects

### User

```json
{
  "id": 1,
  "email": "user@example.com",
  "fullName": "John Doe",
  "picture": "https://example.com/photo.jpg",
  "phoneNumber": null,
  "role": "user",
  "createdAt": "2025-12-29T10:30:00.000Z"
}
```

### Ingredient

```json
{
  "id": 1,
  "name": "Tomato",
  "isAvailable": true,
  "isDeleted": false
}
```

### MenuItemWithUrl

```json
{
  "id": 1,
  "name": "Margherita Pizza",
  "basePrice": 12.99,
  "timeToPrepare": 15,
  "customization": [...],
  "s3Key": "menu-items/1735123456789-pizza.jpg",
  "imageUrl": "http://localhost:8092/menu-items/1735123456789-pizza.jpg",
  "isAvailable": true,
  "createdAt": "2025-12-29T10:30:00.000Z",
  "ingredientIds": [1, 2, 3],
  "isDeleted": false
}
```

### AvailableMenuItem

```json
{
  "id": 1,
  "name": "Margherita Pizza",
  "basePrice": 12.99,
  "timeToPrepare": 15,
  "customization": [
    {
      "title": "Size",
      "pickOne": true,
      "choices": [
        {
          "name": "Small",
          "price": 0.0,
          "isAvailable": true,
          "ingredientIds": null,
          "forSale": true
        }
      ]
    }
  ],
  "s3Key": "menu-items/1735123456789-pizza.jpg",
  "imageUrl": "http://localhost:8092/menu-items/1735123456789-pizza.jpg",
  "isAvailable": true,
  "createdAt": "2025-12-29T10:30:00.000Z",
  "ingredientIds": [1, 2, 3],
  "isDeleted": false,
  "forSale": true
}
```

**Note**: `imageUrl` is computed on GET requests and not stored in the database.

---
