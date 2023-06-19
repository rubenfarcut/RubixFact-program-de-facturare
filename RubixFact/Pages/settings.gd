extends Control

func _enter_tree():
	$Buttons/DATE_FIRMA.text=SceneTransition.firma_mea.nume+"\nCUI:"+SceneTransition.firma_mea.cif
	
	get_node("Buttons/Panel/setari").modulate=Color("#ff3535")

	var save_file = File.new()
	save_file.open("res://date_firma.save", File.READ)
	var content=save_file.get_as_text().split(";")
	$Panel/name/TextEdit.text=content[0]
	$Panel/REG_COM/TextEdit.text=content[1]
	$Panel/CUI/TextEdit.text=content[2]
	$Panel/adresa/TextEdit.text=content[3]
	$Panel/IBAN/TextEdit.text=content[4]
	$Panel/BANCA/TextEdit.text=content[5]
	$Panel/swift/TextEdit.text=content[6]
	$Panel/telefon/TextEdit.text=content[7]
	$Panel/EMAIL/TextEdit.text=content[8]
	$Panel/capital/TextEdit.text=content[9]
	$Panel/nume_res/TextEdit.text=content[10]
	$Panel/cnp/TextEdit.text=content[11]
	$Panel/nume_del/TextEdit.text=content[12]
	$Panel/CI/TextEdit.text=content[13]
	$Panel/auto/TextEdit.text=content[14]
	$Panel/agent/TextEdit.text=content[15]
	$Panel/LOGO/TextEdit.text=content[16]
	save_file.close()
	
	
	
	
	
	
	
	
	
	
	
	
	
func _on_facturare_pressed():
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/facts.tscn")



func _on_stocuri_pressed():
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/stocs.tscn")



func _on_setari_pressed():
	pass # Replace with function body.


func _on_Button_pressed():
	var save_file = File.new()
	save_file.open("res://date_firma.save", File.WRITE)
	save_file.store_string($Panel/name/TextEdit.text+";"+$Panel/REG_COM/TextEdit.text+";"+$Panel/CUI/TextEdit.text+";"+$Panel/adresa/TextEdit.text+";"+$Panel/IBAN/TextEdit.text+";"+$Panel/BANCA/TextEdit.text+";"+$Panel/swift/TextEdit.text+";"+$Panel/telefon/TextEdit.text+";"+$Panel/EMAIL/TextEdit.text+";"+$Panel/capital/TextEdit.text+";"+$Panel/nume_res/TextEdit.text+";"+$Panel/cnp/TextEdit.text+";"+$Panel/nume_del/TextEdit.text+";"+$Panel/CI/TextEdit.text+";"+$Panel/auto/TextEdit.text+";"+$Panel/agent/TextEdit.text+";"+$Panel/LOGO/TextEdit.text)
	save_file.close()
	SceneTransition._ready()
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/settings.tscn")
