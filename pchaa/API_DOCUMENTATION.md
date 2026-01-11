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

### 4. Cart Endpoints

#### GET /cart/getMyCart

Get current user's cart items

- **Auth Required**: Yes (User role)
- **Body**: None
- **Response**: Array of Cart objects

#### GET /cart/getCartById

Get specific cart item by ID

- **Auth Required**: Yes (User role)
- **Body**:

```json
{
  "id": 1
}
```

- **Response**: Cart object or null

#### POST /cart/createCart

Add item to cart

- **Auth Required**: Yes (User role)
- **Body**:

```json
{
  "menuItemId": 1,
  "selectedOptions": [
    {
      "title": "Size",
      "name": "Large",
      "price": 3.0
    }
  ],
  "quantity": 2,
  "additionalMessage": "No onions please"
}
```

**Notes:**
- `menuItemId`: ID of the menu item to add
- `selectedOptions`: Array of selected customization options
- `quantity`: Must be greater than 0
- `additionalMessage`: Optional special instructions
- **Response**: Created Cart object

#### POST /cart/updateCart

Update cart item details

- **Auth Required**: Yes (User role)
- **Body**:

```json
{
  "cartId": 1,
  "selectedOptions": [
    {
      "title": "Size",
      "name": "Small",
      "price": 0.0
    }
  ],
  "quantity": 1,
  "additionalMessage": "Extra sauce"
}
```

**Notes:**
- `cartId`: Cart ID to update (required)
- `selectedOptions`: Updated customization options (required)
- `quantity`: Must be greater than 0 (required)
- `additionalMessage`: Optional special instructions (nullable)
- Menu item must still be available
- **Response**: Updated Cart object

#### POST /cart/deleteCart

Remove item from cart

- **Auth Required**: Yes (User role)
- **Body**:

```json
{
  "cartId": 1
}
```

- **Response**: `true`

#### POST /cart/clearMyCart

Clear all items from user's cart

- **Auth Required**: Yes (User role)
- **Body**: None
- **Response**: `true`

#### POST /cart/increaseCartQuantity

Increase quantity of cart item by 1

- **Auth Required**: Yes (User role)
- **Body**:

```json
{
  "cartId": 1
}
```

- **Response**: `true`

#### POST /cart/decreaseCartQuantity

Decrease quantity of cart item by 1

- **Auth Required**: Yes (User role)
- **Body**:

```json
{
  "cartId": 1
}
```

**Notes:**
- Quantity cannot be less than 1
- **Response**: `true`

---

### 5. Order Endpoints

#### POST /order/createOrder

Create new order from cart items

- **Auth Required**: Yes (User role)
- **Body**:

```json
{
  "replyMessage": "Please make it spicy",
  "orderType": "I",
  "pickupTime": null
}
```

**Parameters:**
- `replyMessage`: Optional message to restaurant (string, nullable)
- `orderType`: "I" for immediate or "S" for scheduled (OrderType)
- `pickupTime`: Required if `orderType` is "S", must be today and in the future, null for immediate orders (DateTime, nullable)

**Notes:**
- User must have items in cart
- For scheduled orders: `pickupTime` must be within the same day
- All menu items in cart must still be available
- Clears cart after order creation
- **Response**: Created Order object

#### GET /order/getMyOrders

Get all orders for current user

- **Auth Required**: Yes (User role)
- **Body**: None
- **Response**: Array of Order objects

#### GET /order/getEstimatedQueue

Get estimated queue wait time for new orders

- **Auth Required**: Yes (User or Owner role)
- **Body**: None
- **Response**: 

```json
{
  "immediateQueue": 15,
  "scheduledQueue": 20
}
```

**Note**: Returns estimated minutes for immediate and scheduled order queues

#### POST /order/confirmOrder

Confirm order and assign queue number (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "orderId": 1
}
```

**Notes:**
- Only orders with status "ordered" can be confirmed
- Automatically assigns queue number (I001, S001, etc.)
- Changes status to "preparing"
- **Response**: Updated Order object

#### POST /order/updateOrderStatus

Update order status (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "orderId": 1,
  "newStatus": "finished"
}
```

**Valid Status Transitions:**
- `ordered` → `preparing`
- `preparing` → `finished`
- `finished` → `received`

**Notes:**
- Cannot change status of cancelled or received orders
- Cannot directly set to "ordered" or "cancelled"
- **Response**: Updated Order object

#### POST /order/cancelMyOrder

Cancel user's own order

- **Auth Required**: Yes (User role)
- **Body**:

```json
{
  "orderId": 1
}
```

**Notes:**
- User can only cancel their own orders
- Only orders with status "ordered" can be cancelled
- **Response**: Updated Order object

#### GET /order/getOrderById

Get order details with items

- **Auth Required**: Yes (User or Owner role)
- **Body**:

```json
{
  "orderId": 1
}
```

**Notes:**
- Users can only view their own orders
- Owners can view any order
- Returns order object and associated order items
- For immediate orders with queue number, includes estimated ready time
- **Response**: 

```json
{
  "order": {Order object},
  "orderItems": [{OrderItem object}, ...],
  "estimatedReadyTime" : 30 // minute
}
```

#### GET /order/getOrderItems

Get items in specific order

- **Auth Required**: Yes (User or Owner role)
- **Body**:

```json
{
  "orderId": 1
}
```

**Notes:**
- Users can only view items from their own orders
- Owners can view items from any order
- **Response**: Array of OrderItem objects

#### GET /order/getTodayOrder

Get all today's orders (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**: None
- **Response**: Array of Order objects

**Notes:**
- Orders are grouped by status in this order: ordered, preparing, finished, received, cancelled
- Within each status group, orders are sorted by queue number (or creation date for ordered/cancelled)

#### GET /order/getFinishedOrders

Get finished orders by type (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "type": "I"
}
```

**Parameters:**
- `type`: "I" for immediate or "S" for scheduled

- **Response**: Array of finished Order objects

#### GET /order/getTodayOrderByType

Get today's orders by specific type (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "type": "I"
}
```

**Parameters:**
- `type`: "I" for immediate or "S" for scheduled

- **Response**: First order of the specified type for today

#### GET /order/getTodayOrderByStatus

Get today's orders filtered by status and optional type (owner only)

- **Auth Required**: Yes (Owner role)
- **Body**:

```json
{
  "status": "preparing",
  "type": "I"
}
```

**Parameters:**
- `status`: "ordered", "preparing", "finished", "received", or "cancelled"
- `type`: Optional - "I" for immediate or "S" for scheduled (if null, returns all types)

- **Response**: Array of Order objects matching filters

---

## Common Response Objects

### Cart

```json
{
  "id": 1,
  "userId": 1,
  "menuItemId": 1,
  "selectedOptions": [
    {
      "title": "Size",
      "name": "Large",
      "price": 3.0
    }
  ],
  "quantity": 2,
  "unitPrice": 15.99,
  "totalPrice": 31.98,
  "additionalMessage": "No onions please"
}
```

### Order

```json
{
  "id": 1,
  "userId": 1,
  "status": "preparing",
  "type": "I",
  "queueNumber": "I001",
  "totalOrderPrice": 31.98,
  "orderDate": "2026-01-12T00:00:00.000Z",
  "pickupTime": null,
  "replyMessage": "Please make it spicy",
  "createdAt": "2026-01-12T14:30:00.000Z"
}
```

### OrderItem

```json
{
  "id": 1,
  "orderId": 1,
  "menuItemId": 1,
  "itemName": "Pad Thai",
  "selectedOptions": [
    {
      "title": "Spice Level",
      "name": "Very Spicy",
      "price": 0.0
    }
  ],
  "quantity": 2,
  "finalPrice": 31.98
}
```

**Enum Values:**

**OrderStatus:**
- `ordered`: Initial state when order is created
- `preparing`: Order is being prepared
- `finished`: Order is ready for pickup
- `received`: Customer has received the order
- `cancelled`: Order has been cancelled

**OrderType:**
- `I`: Immediate order (pickup ASAP)
- `S`: Scheduled order (pickup at specific time)
