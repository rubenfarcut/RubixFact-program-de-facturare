extends Control

#warning-ignore-all:unused_variable
var nume;var total=0;var produs="";var adresa;var judet;var localitate; var tara;var cui; var rc; var iban; var banca; var cod_client;var telefon;var email;var seria;var numar; var data;
var nume_factura;var kont=0;
func _enter_tree():
	$item_search/item.visible=false
	$item_search/item2.visible=false
	$Buttons/DATE_FIRMA.text=SceneTransition.firma_mea.nume+"\nCUI:"+SceneTransition.firma_mea.cif
	$Panel_add/Panel/Object.visible=false
	$Panel_add/Panel.visible=false

#	var test =str(OS.get_executable_path())
#	while test[len(test)-1]!="/":
#		test.erase(test.length()-1,1)
#	print (test)
#	print(OS.get_executable_path())
#	OS.shell_open(str(test))
	get_node("Buttons/Panel/fact").modulate=Color("#ff3535")
	loade()
	get_node("Panel2/produus").visible=false
	get_node("Panel2/Numar/TextEdit").text=numar
	get_node("Panel2/Serie/TextEdit").text=seria
	for obj in get_children():
		obj.visible = false
	get_node("Buttons").visible=true
	get_node("Panel").visible=1
	if(OS.get_date().day>=10 and OS.get_date().month>=10):
		get_node("Panel2/Data/TextEdit").text=str(OS.get_date().day)+"."+str(OS.get_date().month)+"."+str(OS.get_date().year)
	if(OS.get_date().day<10 and OS.get_date().month>=10):
		get_node("Panel2/Data/TextEdit").text="0"+str(OS.get_date().day)+"."+str(OS.get_date().month)+"."+str(OS.get_date().year)
	if(OS.get_date().day>=10 and OS.get_date().month<10):
		get_node("Panel2/Data/TextEdit").text=str(OS.get_date().day)+".0"+str(OS.get_date().month)+"."+str(OS.get_date().year)
	if(OS.get_date().day<10 and OS.get_date().month<10):
		get_node("Panel2/Data/TextEdit").text="0"+str(OS.get_date().day)+".0"+str(OS.get_date().month)+"."+str(OS.get_date().year)




func _on_Continua_pressed():
	$item_search.visible=false
	get_node("Panel").visible=false
	get_node("Panel2").visible=true
	

func _on_Inapoi_pressed():
	get_node("Panel2").visible=false
	get_node("Panel").visible=true

func read_variable():
	nume = get_node("Panel/Nume/TextEdit").text
	adresa = get_node("Panel/Adresa/TextEdit").text
	judet = get_node("Panel/Judet/TextEdit").text
	localitate=get_node("Panel/Localitate/TextEdit").text
	tara=get_node("Panel/Tara/TextEdit").text
	cui=get_node("Panel/Cod_fiscal/TextEdit").text
	rc=get_node("Panel/Reg_comert/TextEdit").text
	iban=get_node("Panel/Iban/TextEdit").text
	banca=get_node("Panel/Banca/TextEdit").text
	cod_client=get_node("Panel/Cod_client/TextEdit").text
	telefon=get_node("Panel/Telefon/TextEdit").text
	email=get_node("Panel/Email/TextEdit").text
	seria=get_node("Panel2/Serie/TextEdit").text
	numar=get_node("Panel2/Numar/TextEdit").text
	data=get_node("Panel2/Data/TextEdit").text
	
func generate_html(filename, content):
	# Deschide fisierul pentru scriere
	var file
	file = File.new()
	file.open("../Facturi/"+filename, File.WRITE)
	# Scrie continutul in fisier
	file.store_string(content)
	# Inchide fisierul
	
	file.close()

	
func _on_gen_fact_pressed():
	var filepath = "res://stoc.save.xls"
	var file = File.new()
	file.open(filepath, File.READ)
	var file_contents = file.get_as_text()
	file.close()
	var cer=file_contents.split("\n")
	for obj in $Panel2/ColorRect/ScrollContainer/VBoxContainer.get_children():
		for i in range(0,cer.size()):
			
			var cerar=cer[i].split(",")
			
			
			
			if obj.get_node("Label").text in cerar[0] and cerar[0] in obj.get_node("Label").text:
				cerar[1]=str(int(cerar[1])-int(obj.get_node("Label2").text))
				
				cer[i]=(cerar[0]+","+cerar[1]+","+cerar[2])
				
				break
			
	cer= cer.join(",\n")
	file_contents=cer
	file.open(filepath, File.WRITE)
	
	file.store_string(file_contents)
	file.close()
	
	
	
	var dir = Directory.new()
	dir.open("../")

	if !dir.dir_exists("Facturi"):
		dir.make_dir("Facturi")
	read_variable()
	generate_html("Factura_"+get_node("Panel2/Serie/TextEdit").text+"-"+get_node("Panel2/Numar/TextEdit").text+".html",content())
	nume_factura="Factura_"+get_node("Panel2/Serie/TextEdit").text+"-"+get_node("Panel2/Numar/TextEdit").text
	
#	print (nume_factura)
#	var exec=OS.execute("wkhtmltopdf//bin//wkhtmltopdf.exe", ["--no-stop-slow-scripts","--enable-local-file-access", "--javascript-delay", "5000" , "--page-size" ,"A4" ,"--no-background" ,"--margin-left" ,"10mm" ,"--margin-right","10mm","--zoom" ,"1.3","..\\Facturi\\"+nume_factura+".html", "..\\Facturi\\"+nume_factura+".pdf"])
	var exec=OS.execute("wkhtmltopdf//bin//wkhtmltopdf.exe", ["--no-stop-slow-scripts","--enable-local-file-access","--disable-smart-shrinking","..\\Facturi\\"+nume_factura+".html", "..\\Facturi\\"+nume_factura+".pdf"])
	var make=OS.shell_open("..\\Facturi\\"+nume_factura+".pdf")
	
	nume_factura=nume_factura+".html"
	get_node("Panel2/Numar/TextEdit").text=str(int(get_node("Panel2/Numar/TextEdit").text)+1)

	
	
	numar=str(int(numar)+1)
	savee()
	reset()
	for obj in $Panel2/ColorRect/ScrollContainer/VBoxContainer.get_children():
		obj.queue_free()
	for obj in $Panel_add/Panel/ScrollContainer/VBoxContainer.get_children():
		obj.queue_free()
	
func content():
	var content="""<!DOCTYPE html>
	<html lang="ro">
	<head>
	<meta charset="UTF-8">
	<title>Factura generata cu RUBIXFACT</title>
	<style>
	@import "https://fonts.googleapis.com/css?family=Open+Sans:400,400i,600,600i,700";html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,embed,figure,figcaption,footer,header,hgroup,menu,nav,output,ruby,section,total,time,mark,audio,video{margin:0;padding:0;border:0;font-size:100%;font:inherit;vertical-align:baseline}article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block}body{line-height:1}ol,ul{list-style:none}blockquote,q{quotes:none}blockquote:before,blockquote:after,q:before,q:after{content:'';content:none}table{border-collapse:collapse;border-spacing:0}strong{font-weight:700}#container{position:relative;padding:4%}#header{height:80px}#header > #reference{float:right;text-align:right}#header > #reference h3{margin:0}#header > #reference h4{margin:0;font-size:85%;font-weight:600}#header > #reference p{margin:0;margin-top:2%;font-size:85%}#header > #logo{width:50%;float:left}#fromto{height:160px}#fromto > #from,#fromto > #to{width:32%;margin-top: 0px;min-height:90px;font-size:85%;padding:1.5%;line-height:120%}#to1{width:25%;min-height:90px;margin-top:5%;padding:1.5%;line-height:120%}#fromto > #from{float:left;width:32%;background:#efefef;margin-top:20px;font-size:85%;padding:1.5%}#fromto > #to{margin-top:20px;float:right;border:solid grey 1px;}#to1{margin: auto;text-align: center;display: inline-block;margin-top:20px;font-size:100%;padding:1.5%}#items{margin-top:10px}#items > p{font-weight:700;text-align:right;margin-bottom:1%;font-size:65%}#items > table{width:100%;font-size:85%;border:solid grey 1px}#items > table th:first-child{text-align:center}#items > table th{font-weight:400;padding:1px 4px;}#items > table td{padding:1px 4px;text-align: center;}#items > table th:nth-child(1),#items > table th:nth-child(4){width:80px;}#items >table th:nth-child(1){width:5px;}#items > table th:nth-child(5){width:80px}#items > table th:nth-child(3){width:80px}#items > table tr td:not(:first-child){text-align:center;padding-right:1%}#items table td{border-right:solid grey 1px}#items table tr td{padding-top:3px;padding-bottom:3px;height:10px}#items table tr:nth-child(1){border:solid grey 1px}#items table tr:nth-child(2){border:solid grey 1px}#items table tr th{border-right:solid grey 1px;padding:3px}#items table tr:nth-child(2) > td{padding-top:8px}#summary{height:170px;margin-top:30px}#summary #note{float:left}#summary #note h4{font-size:10px;font-weight:600;font-style:italic;margin-bottom:4px}#summary #note p{font-size:10px;font-style:italic}#summary #total table{font-size:85%;width:260px;float:right}#summary #total table td{padding:3px 4px}#summary #total table tr td:last-child{text-align:right}#summary #total table tr:nth-child(3){background:#efefef;font-weight:600}#footer{margin:auto;position:absolute;left:4%;bottom:4%;right:4%;border-top:solid grey 1px}#footer p{margin-top:1%;font-size:65%;line-height:140%;text-align:center}
</style>
</head>
<body>






	<div id="fromto">
		<div id="from">
			<p>
				<i>Furnizor:</i><br>
				<strong>"""+SceneTransition.firma_mea.nume+"""</strong><br><br>
				 <strong>Reg. com.:</strong>"""+SceneTransition.firma_mea.reg_com+"""<br>
				 <strong>CIF:</strong> """+SceneTransition.firma_mea.cif+"""
				 <br><strong>Adres&#259;:</strong>
				 """+SceneTransition.firma_mea.adresa+""" <br>
				 
				 <strong>IBAN (RON):</strong>	"""+SceneTransition.firma_mea.iban+"""<br>
				 <strong>Banca:</strong>	"""+SceneTransition.firma_mea.banca+"""<br>
				 <strong>SWIFT:</strong>	"""+SceneTransition.firma_mea.swift+"""<br>
				 <strong>Tel.:</strong>	"""+SceneTransition.firma_mea.telefon+"""<br>
				 <strong>Email:</strong>	"""+SceneTransition.firma_mea.email+"""<br>
				 <strong>Capital social:</strong>	"""+SceneTransition.firma_mea.capital_social+"""<br>
			</p>
		</div>
		<div id="to1">
			<p>
				<h3><strong>Factur&#259;</strong></h3>
			<h4>Serie-Num&#259;r<br>
				 """+seria+"""-"""+numar+"""</h4>
			<p>Data emiterii<br>
				"""+data+"""</p>
				<br>
				
				<img src="""+"\""+SceneTransition.firma_mea.logo+"\""+""" alt="logo" style="width:6em; height: 6em;">
		
		</div>
		<div id="to">
			<p>
				<i>Client:</i><br>
				<strong>"""+nume+"""</strong><br><br>"""
	if $Panel/Reg_comert/TextEdit.text!="":
		content=content+"""
				<strong>Reg. com.:</strong> """+rc+"""<br>"""
	if $Panel/Cod_fiscal/TextEdit.text!="":
		content=content+"""
				<strong>CIF:</strong>"""+cui+"""	<br>"""
	content=content+"""
				<strong>Adres&#259;:</strong>"""+adresa+""","""+localitate+""" <br>
				<strong>Jude&#355;:</strong>"""+judet+"""	<br>
				<strong>&#354;ar&#259;:</strong>	"""+tara
	if $Panel/Banca/TextEdit.text!="":
		content=content+"""<br><strong>Banca:</strong> """+ banca
	if $Panel/Iban/TextEdit.text!="":
		content=content+"""<br><strong>Iban:</strong> """+ iban
	if $Panel/Telefon/TextEdit.text!="":
		content=content+"""<br><strong>Telefon:</strong> """+ telefon
	if $Panel/Email/TextEdit.text!="":
		content=content+"""<br><strong>Email:</strong> """+ email
	content=content+"""
			</p>
		</div>
	</div>
	
<br><br><br>
	<div id="items">
		<p></p>
		<table>
			<tr>
				<th>Num&#259;r</th>
				<th>Denumire produs/serviciu</th>
			
				<th>Cantitate (BUC)</th>
				<th>Pre&#355; unitar (RON)</th>
				<th>Valoare (RON)</th>
			</tr>
			<tr>
				<th>0</th>
				<th>1</th>
				
				<th>2</th>
				<th>3</th>
				<th>(2x3) 4</th>
			</tr>
			
 
	"""+produs+"""


			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
	<div id="note">
			
		<p style="font-size:xx-small;color: gray;">Factura circul&#259; f&#259;r&#259; semnatur&#259; &#351;i &#351;tampil&#259; conform codului
			fiscal, art. 319, alin.29 &#351;i poate fi acceptat&#259; &#238;n format electronic.</p>
		</div> 
	<div id="summary">
		
		
		<table style="border: 1cm; display: inline-block;">
			<tr style="border: 1px solid grey;
			padding: 8px;
			text-align: left;">
				<th style="border: 1px solid grey;
				padding: 8px;
				text-align: left;"><strong>&#206;ntocmit de:</strong><br>"""+SceneTransition.firma_mea.responsabil.nume+"""<br><strong>CNP:</strong><br>"""+SceneTransition.firma_mea.responsabil.cnp+"""</th>
				<th style="border: 1px solid grey;
				padding: 8px;
				text-align: left;"><strong>Date privind expedi&#355;ia:</strong><br>Numele delegatului: """+SceneTransition.firma_mea.delegat.nume+""",<br> CI: """+SceneTransition.firma_mea.delegat.ci+""".<br> Expediere la data de .........., ora .....</th>
				<th style="border: 1px solid grey;
				padding: 8px;
				text-align: left;"><strong>Semn&#259;tura<br> de primire:</strong></th>
				
			</tr>
			
		</table>
	

		<div id="total" style=" float: right;">
			<table style="border:1cm;">
				
				
				<tr>
					<td><strong style="font-size: large;">Total de plat&#259;</strong></td>
					<td><strong style="font-size: large;">"""+str(total)+""" RON</strong></td>
				</tr>
			</table>
		</div>
	<!-- </div>

	<div id="footer">
		<p></p>
	</div> -->
</div>

</body>
</html>

	

	"""
	return content
	
func products():
	kont+=1
	produs=produs+ """ 
	<tr><td>"""+str(kont)+"""</td>
	<td style="text-align: left;">"""+get_node("Panel_add/Produs/TextEdit").text+"""</td>
	<td>"""+get_node("Panel_add/Cantitate/TextEdit").text+"""</td></td>
	<td>"""+get_node("Panel_add/Pret/TextEdit").text+"""</td>
	<td>"""+str(float(get_node("Panel_add/Pret/TextEdit").text)*float(get_node("Panel_add/Cantitate/TextEdit").text))+"""</td>
	</tr>"""
	total =total+float(get_node("Panel_add/Pret/TextEdit").text)*float(get_node("Panel_add/Cantitate/TextEdit").text)
	
func reset():
	get_node("Panel/Nume/TextEdit").text=""
	get_node("Panel/Adresa/TextEdit").text=""
	get_node("Panel/Judet/TextEdit").text=""
	get_node("Panel/Localitate/TextEdit").text=""
	get_node("Panel/Tara/TextEdit").text="Romania"
	get_node("Panel/Cod_fiscal/TextEdit").text=""
	get_node("Panel/Reg_comert/TextEdit").text=""
	get_node("Panel/Iban/TextEdit").text=""
	get_node("Panel/Banca/TextEdit").text=""
	get_node("Panel/Cod_client/TextEdit").text=""
	get_node("Panel/Telefon/TextEdit").text=""
	get_node("Panel/Email/TextEdit").text=""
	kont=0
	produs=""
	total=0
	var children = get_node("Panel2/ColorRect/ScrollContainer/VBoxContainer").get_children()
	for child in children:
		child.queue_free()
func _on_fact_pressed():
	reset()
	get_node("Panel").visible=true
	get_node("Panel2").visible=false
	
func _on_stoc_pressed():
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/stocs.tscn")




func _on_add_pressed():
	get_node("Panel_add").visible=true

func _on_close_add_pressed():
	get_node("Panel_add/Cantitate/TextEdit").text=""
	get_node("Panel_add/Pret/TextEdit").text=""
	get_node("Panel_add/Produs/TextEdit").text=""
	get_node("Panel_add").visible=false
	$Panel_add/Panel.visible=false

func _on_Button_add_pressed():
	products()
	$Panel_add/Panel.visible=false
	var vbox = get_node("Panel2/ColorRect/ScrollContainer/VBoxContainer")
	#var prod = Label.new()
	
	#prod.text=get_node("Panel_add/Produs/TextEdit").text+" ----- "+get_node("Panel_add/Pret/TextEdit").text+" ---- "+get_node("Panel_add/Cantitate/TextEdit").text+" ---- "+str(float (get_node("Panel_add/Pret/TextEdit").text)*float (get_node("Panel_add/Cantitate/TextEdit").text))
	#prod.set("custom_colors/font_color", Color(0,0,0))
	var prod = get_node("Panel2/produus").duplicate()
	prod.visible=true
	prod.get_node("Label").text=get_node("Panel_add/Produs/TextEdit").text
	prod.get_node("Label3").text=get_node("Panel_add/Pret/TextEdit").text
	prod.get_node("Label2").text=get_node("Panel_add/Cantitate/TextEdit").text
	prod.get_node("Label4").text=str(float (get_node("Panel_add/Pret/TextEdit").text)*float (get_node("Panel_add/Cantitate/TextEdit").text))
	vbox.add_child(prod)
	
	get_node("Panel_add/Cantitate/TextEdit").text=""
	get_node("Panel_add/Pret/TextEdit").text=""
	get_node("Panel_add/Produs/TextEdit").text=""
	
	get_node("Panel_add").visible=false

func loade():
	var save_file = File.new()
	if not save_file.file_exists("res://savefile.save"):
		return
	save_file.open("res://savefile.save", File.READ)
	seria = str(save_file.get_line())
	numar = str(save_file.get_line())

	
	save_file.close()

func savee():
	var save_file = File.new()
	save_file.open("res://savefile.save", File.WRITE)
	save_file.store_line(str(seria))
	save_file.store_line(str(numar))
	
	save_file.close()





func _on_TextEdit_text_changed():
	var text=get_node("Panel_add/Produs/TextEdit")
	if(text.text!=""):
		$Panel_add/Panel.visible=true
	else:
		$Panel_add/Panel.visible=false
	var save_file = File.new()
	var vbox=get_node("Panel_add/Panel/ScrollContainer/VBoxContainer")
	save_file.open("res://stoc.save.xls", File.READ)
	
	var test=save_file.get_line()

	while !save_file.eof_reached():	
		var produs1=get_node("Panel_add/Panel/Object")
		test=str(save_file.get_line())
		if str(test)!="":
			var decript=test.split(",")
			if($Panel_add/Produs/TextEdit.text.to_lower() in decript[0].to_lower()):
				produs1=produs1.duplicate()
				produs1.visible=true
				vbox.add_child(produs1)
				produs1.text=decript[0]+"("+decript[1]+")"
				produs1.pret=decript[2]
	
	for i in range(vbox.get_child_count()):
		for j in range(i+1, vbox.get_child_count()):
			var child1 = vbox.get_child(i)
			var child2 = vbox.get_child(j)
			if child1.text==child2.text:
				child2.queue_free()
	for obj in vbox.get_children():
		if $Panel_add/Produs/TextEdit.text.to_lower() in obj.text.to_lower():
			obj.visible=true

		else:
			obj.queue_free()
	if vbox.get_child_count()==0:
		$Panel_add/Panel.visible=false


func _on_Object_pressed():
	var vbox=$Panel_add/Panel/ScrollContainer/VBoxContainer
	for child in vbox.get_children():
		if child.is_pressed():
			var el=child.text
			el.erase(child.text.find("("), child.text.find(")")-child.text.find("(*")+1)
			$Panel_add/Produs/TextEdit.text=el
			$Panel_add/Cantitate/TextEdit.text="1"
			$Panel_add/Pret/TextEdit.text=child.pret


func _on_setari_pressed():
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene("res://Pages/settings.tscn")



func textedit_judet():
	$item_search.visible=true
	
	var file = File.new()
	file.open("res://judete.json",File.READ)
	var text_json = file.get_as_text()
	var result_json = JSON.parse(text_json).result
	var i=0
	
	for x in result_json["judete"]:
		
		i+=1;
		if $Panel/Judet/TextEdit.text.to_lower() in x["nume"].to_lower():
			var obj=$item_search/item.duplicate()
			$item_search/ScrollContainer/VBoxContainer.add_child(obj)
			obj.visible=true
			obj.text=x["nume"]
			
	for obj in $item_search/ScrollContainer/VBoxContainer.get_children():
		if !($Panel/Judet/TextEdit.text.to_lower() in obj.text.to_lower()):
			obj.queue_free()
	for obj1 in range(0, $item_search/ScrollContainer/VBoxContainer.get_child_count()):
			for obj2 in range(obj1+1,$item_search/ScrollContainer/VBoxContainer.get_child_count()):
				if($item_search/ScrollContainer/VBoxContainer.get_child(obj1).text.to_lower()==$item_search/ScrollContainer/VBoxContainer.get_child(obj2).text.to_lower()):
					$item_search/ScrollContainer/VBoxContainer.get_child(obj2).queue_free()
		
#	i=3
#	var x=result_json["judete"]
#	for k in x[i]["localitati"]:
#		print(k["nume"])
	
	file.close()
	

func _on_item_pressed():
	var vbox=$item_search/ScrollContainer/VBoxContainer
	for child in vbox.get_children():
		if child.is_pressed():
			var el=child.text
			$Panel/Judet/TextEdit.text=el


func judet_focus_exited():
	$item_search/Timer.start()
	yield($item_search/Timer, "timeout")
	$item_search/Timer.stop()
	$item_search.visible=false
	for obj in $item_search/ScrollContainer/VBoxContainer.get_children():
		obj.queue_free()


func localitate_focus_exited():
	$item_search/Timer.start()
	yield($item_search/Timer, "timeout")
	$item_search/Timer.stop()
	$item_search.visible=false
	for obj in $item_search/ScrollContainer/VBoxContainer.get_children():
		obj.queue_free()
func indice():
	var file = File.new()
	file.open("res://judete.json",File.READ)
	var text_json = file.get_as_text()
	var result_json = JSON.parse(text_json).result
	var i=0
	
	for x in result_json["judete"]:
		i+=1;
		if x["nume"].to_lower()==$Panel/Judet/TextEdit.text.to_lower():
			break;
	return i;

func localitate_text_changed():
	$item_search.visible=true
	var file = File.new()
	file.open("res://judete.json",File.READ)
	var text_json = file.get_as_text()
	var result_json = JSON.parse(text_json).result
	var i=indice()-1
	var x=result_json["judete"]
	for k in x[i]["localitati"]:
		var l = k["nume"]
		if($Panel/Localitate/TextEdit.text.to_lower() in l.to_lower()):
			var obj=$item_search/item2.duplicate()
			$item_search/ScrollContainer/VBoxContainer.add_child(obj)
			obj.visible=true
			obj.text=l
	for obj in $item_search/ScrollContainer/VBoxContainer.get_children():
		if !($Panel/Localitate/TextEdit.text.to_lower() in obj.text.to_lower()):
			obj.queue_free()
	for obj1 in range(0, $item_search/ScrollContainer/VBoxContainer.get_child_count()):
			for obj2 in range(obj1+1,$item_search/ScrollContainer/VBoxContainer.get_child_count()):
				if($item_search/ScrollContainer/VBoxContainer.get_child(obj1).text.to_lower()==$item_search/ScrollContainer/VBoxContainer.get_child(obj2).text.to_lower()):
					$item_search/ScrollContainer/VBoxContainer.get_child(obj2).queue_free()
		
		
func _on_item2_pressed():
	var vbox=$item_search/ScrollContainer/VBoxContainer
	for child in vbox.get_children():
		if child.is_pressed():
			var el=child.text
			$Panel/Localitate/TextEdit.text=el
