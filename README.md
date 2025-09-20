# 🍏 Juice Processing & Packaging System

A **full-stack application** for managing juice processing and packaging operations.  
The system streamlines everything from customer entry to final pickup — with optional integrations for industrial printers and SMS notifications.

---

## 🛠 Tech Stack

- **Backend**: Node.js + Express  
- **Frontend**: React (with Vite)  
- **Database**: AWS RDS (PostgreSQL/MySQL)  
- **Notifications**: AWS SNS (SMS)  
- **Containerization**: Docker & Docker Compose  

---

## 📊 Features & Pages

### Default login page
- Use "employee123" default password to login the system
- The password could be changed in the setting page
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/e7d52d87-41b3-4540-8137-811e9bf1d01f" />


### 1. Dashboard
- Displays production statistics, line productivity, and recent activity.
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/9c106ee7-1a85-4208-a704-70da84d48fcf" />

### 2. Customer Info Entry
- Record customer details and apple weight.  
- Auto-calculates juice quantity, pouch count, and price (based on city).  
- Optional notes for special cases.  
- Generates **crate QR codes** based on employee input.
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/845b90cc-db60-4baa-a2a2-58e9d8576216" />

### 3. Crate Management
- Employees scan crate QR codes once apples are ready.  
- Order status updates automatically.  
- Moves to *Juice Processing* once all crates are scanned.
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/ffed46a6-a6cc-4a17-8930-d5d08fc54271" />

### 4. Juice Processing
- Shows orders ready for juice extraction and pouch filling.  
- Generates **Box QR codes** and sends to printer.  
- Sends **Customer Name + Expiry Date** to the Videojet industrial printer.  
- Employees mark orders as *done* after processing, labeling, and packing.
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/912e83d8-78cc-435d-8f16-4aefe6269922" />

### 5. Load Boxes → Pallet
- Each pallet has its own QR code (holds up to **4 boxes**).  
- Employees scan box QR codes, then assign them to pallets.  
- Pallets can be moved to storage, even in different cities.
- If the customer origin of the box is Kuopio, then scan the shelf QR codes immediately 
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/955af093-7267-4feb-8b2f-a526ad6a4f8a" />

### 6. Load Pallet → Shelf
- Each shelf has its own QR code (holds **1 pallet**).  
- Employees scan pallet → shelf.  
- System automatically sends an **SMS notification** to the customer when their order is shelved.
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/00eb5c43-2695-400c-b323-6b22c58c24c4" />

### 7. Pickup Coordination
- Search by **customer name** or **phone number**.  
- System shows which shelf contains the order.  
- Employees mark orders as *picked up* once collected.
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/6b346650-6c6c-43df-80fa-c6679caa3c6b" />
<img width="790" height="595" alt="image" src="https://github.com/user-attachments/assets/8293b212-c8ac-4cb6-9a4b-47d6241a5b19" />


### 8. Settings (Admin Only)
- Admin password ("admin123") required for every change.  
- Manage system-wide configuration securely.
- Edit SMS notification template
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/33cc01bd-bf90-4270-95d6-3eb5ae52953e" />

### 9. Customer Management
- Allows viewing, editing, and removing existing customer records.
- Use the admin password to delete any customers -> to prevent employee misbehaviors.
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/3f7a0e27-c201-48c3-8112-c1d79541558f" />

---

## 🐳 Docker Setup

Clone the repository:

```bash
git clone https://github.com/vincentbui21/SmartJuiceSystem.git
cd SmartJuiceSystem
```
Build and start containers:

```bash
docker compose up --build
```
Access the apps:

```bash
Frontend (Vite) → http://localhost:5173
Backend (API) → http://localhost:5001
```
Stop containers:

```bash
docker compose down
```
⚙️ Environment Variables (Optional)
You can create a .env file in the backend folder to configure optional features like AWS SNS:
```env
# AWS SNS configuration
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
SNS_TOPIC_ARN=
AWS_REGION=
DEFAULT_SMS_COUNTRY_CODE=+358
```
These are entirely optional. The system will work fully without them — SMS notifications and auto-label printing will simply be disabled.
👉 If AWS SNS or the industrial printer aren’t available, the system still works — just without SMS and auto-printing.

---
## 🔄 Workflow Summary
1. Login: Use the employee account (employee / employee123) to access the system.
2. Add a New Customer: Enter customer details → generate crate QR codes.
3. Crate Scanning: Scan crates → order moves to juice processing.
4. Juice Processing: Fill pouches → generate box QR codes → send to printer (optional).
5. Load Boxes → Pallet: Scan boxes → assign to pallets.
6. Load Pallet → Shelf: Scan pallets → assign to shelves → SMS notification sent (if configured).
7. Pickup Coordination: Search by customer → mark orders as picked up.

---
## ⚠️ Notes
The system is fully functional even without:

* Industrial printer → no auto-label printing
* AWS SNS → no SMS notifications

Alternative database setups are supported (local PostgreSQL/MySQL).

## 🗃️Database Setup

Before running the backend, the database will be automatically initialized by Docker using the files in Database/.
Optional: You can replace AWS RDS with any local PostgreSQL/MySQL instance if preferred.
