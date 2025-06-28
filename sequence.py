# Rebuild UML file content again
puml_lines = [
    "@startuml",
    "' Laravel Filament Sequence Diagram - Registration & Admin/User Dashboard Flow",
    "title Laravel Filament Resource Sequence Diagram",
    "",
    "actor User",
    "participant \"Web (routes/web.php)\" as Web",
    "participant \"Controller\" as Controller",
    "participant \"Filament Admin Pages\" as Admin",
    "participant \"Filament User Pages\" as UserPanel",
    "participant \"Models\" as Models",
    "participant \"Views\" as Views",
    "",
    "User -> Web : access /daftar",
    "Web -> Controller : PendaftaranController@showForm()",
    "Controller -> Views : form-pendaftaran.blade.php",
    "",
    "User -> Web : submit pendaftaran",
    "Web -> Controller : PendaftaranController@store()",
    "Controller -> Models : create DataSantri, User",
    "Models -> Views : redirect to success",
    "",
    "User -> Web : login as admin",
    "Web -> Controller : AuthController@login()",
    "Controller -> Admin : AdminDashboard.php",
    "Admin -> Models : load VerifikasiBerkas",
    "Admin -> Views : ListVerifikasiBerkas.blade.php",
    "",
    "User -> Web : login as user",
    "Web -> Controller : AuthController@login()",
    "Controller -> UserPanel : UserDashboard.php",
    "UserPanel -> Models : fetch Pembayaran",
    "UserPanel -> Views : ListPembayaran.blade.php",
    "User -> UserPanel : trigger bayar",
    "UserPanel -> Models : create Transaksi",
    "UserPanel -> Views : redirect to pay.blade.php",
    "",
    "@enduml"
]

# Save the .puml file
uml_path = "./laravel_sequence.puml"
with open(uml_path, "w", encoding="utf-8") as f:
    f.write('\n'.join(puml_lines))

uml_path

