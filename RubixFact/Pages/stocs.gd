extends Control

func _enter_tree():
	
	$Buttons/DATE_FIRMA.text=SceneTransition.firma_mea.nume+"\nCUI:"+SceneTransition.firma_mea.cif
	get_node("Buttons/Panel/stocuri").modulate=Color("#ff3535")
	$Object.visible=false
	loade()
	$Panel2.visible=false

func _on_stocuri_pressed():
	pass
func _on_facturare_pressed():
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/facts.tscn")

func loade():
	var save_file = File.new()
	var vbox=get_node("Panel/ColorRect/ScrollContainer/VBoxContainer")

	save_file.open("res://stoc.save.xls", File.READ)
	var produs=get_node("Object")
	var test=save_file.get_line()
	while !save_file.eof_reached():
		test=str(save_file.get_line())
		if str(test)!="":
			var decript=test.split(",")
			produs=produs.duplicate()
			produs.visible=true
			vbox.add_child(produs)
			produs.get_node("Label").text=decript[0]
			produs.get_node("LineEdit").text=decript[1]
			produs.get_node("LineEdit2").text=decript[2]
		
	save_file.close()

func savee():
	var save_file = File.new()

	save_file.open("res://stoc.save.xls", File.WRITE)
	save_file.store_line("Produs,Cantitate,Pret vanzare")

	var produs=get_node("Panel/ColorRect/ScrollContainer/VBoxContainer")
	
	for obj in produs.get_children():
		if float(obj.get_node("LineEdit").text)>0:
			save_file.store_line(obj.get_node("Label").text+","+obj.get_node("LineEdit").text+","+obj.get_node("LineEdit2").text)
	save_file.close()
	




func _on_save_button_pressed():
	savee()
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/stocs.tscn")


func _on_search_text_changed(new_text):
	var produs=get_node("Panel/ColorRect/ScrollContainer/VBoxContainer")
	if new_text=="":
		for obj in produs.get_children():
			obj.visible=true
		return
	for obj in produs.get_children():
		if new_text.to_lower() in obj.get_node("Label").text.to_lower():
			obj.visible=true
		else:
			obj.visible=false
			


func _on_setari_pressed():
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/settings.tscn")


func _on_receptie_pressed():
	$Panel2/prod_add.visible=false
	
	if(OS.get_date().day>=10 and OS.get_date().month>=10):
		get_node("Panel2/data/LineEdit").text=str(OS.get_date().day)+"."+str(OS.get_date().month)+"."+str(OS.get_date().year)
	if(OS.get_date().day<10 and OS.get_date().month>=10):
		get_node("Panel2/data/LineEdit").text="0"+str(OS.get_date().day)+"."+str(OS.get_date().month)+"."+str(OS.get_date().year)
	if(OS.get_date().day>=10 and OS.get_date().month<10):
		get_node("Panel2/data/LineEdit").text=str(OS.get_date().day)+".0"+str(OS.get_date().month)+"."+str(OS.get_date().year)
	if(OS.get_date().day<10 and OS.get_date().month<10):
		get_node("Panel2/data/LineEdit").text="0"+str(OS.get_date().day)+".0"+str(OS.get_date().month)+"."+str(OS.get_date().year)

	
	var save_file = File.new()
	save_file.open("res://NIR.save", File.READ)
	$Panel2/SERIA/LineEdit.text = str(save_file.get_line())
	$Panel2/NUMAR/LineEdit.text = str(save_file.get_line())
	$Panel2/receptioner/TextEdit.text = str(save_file.get_line())
	save_file.close()

	$Panel2.visible=true
	$Panel.visible=false


func _on_anulare_pressed():
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/stocs.tscn")


func _on_Creare_pressed():
	var save_file = File.new()
	save_file.open("res://NIR.save", File.WRITE)
	save_file.store_string($Panel2/SERIA/LineEdit.text+"\n")
	$Panel2/NUMAR/LineEdit.text=str(int($Panel2/NUMAR/LineEdit.text)+1)
	save_file.store_string($Panel2/NUMAR/LineEdit.text+"\n")
	save_file.store_string($Panel2/receptioner/TextEdit.text)
	save_file.close()
	
	var file=File.new()
	file.open("res://stoc.save.xls",File.READ_WRITE)
	var vbox=$Panel2/ScrollContainer/VBoxContainer
	var content = file.get_as_text().split("\n")
	for obj in vbox.get_children():
		for i in range(1,content.size()):
			var name = content[i].split(",")
			if(obj.get_node("Label").text.to_lower() in name[0].to_lower())&&(name[0].to_lower() in obj.get_node("Label").text.to_lower()):
				name[1]=str(float(name[1])+float(obj.get_node("LineEdit").text))
				content[i]=name.join(",")
				obj.visible=false
				break
	var test=content.join("\n")
	
	for obj in vbox.get_children():			
		if obj.visible==true:
		#	test.erase(test.length()-1,1)
			test = test+obj.get_node("Label").text+","+obj.get_node("LineEdit").text+","+obj.get_node("LineEdit2").text+"\n"
	content=test
	
	file.store_string(content)
	file.close()
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/stocs.tscn")
	


func _on_ADDNIR_pressed():
	var vbox=$Panel2/ScrollContainer/VBoxContainer
	var produs=$Object
	produs=produs.duplicate()
	produs.visible=true
	produs.get_node("Label").text=$Panel2/Panel_add/produs.text
	produs.get_node("LineEdit").text=$Panel2/Panel_add/cantitate.text
	produs.get_node("LineEdit2").text=$Panel2/Panel_add/pret.text
	$Panel2/Panel_add/produs.text=""
	$Panel2/Panel_add/cantitate.text=""
	$Panel2/Panel_add/pret.text=""
	vbox.add_child(produs)
