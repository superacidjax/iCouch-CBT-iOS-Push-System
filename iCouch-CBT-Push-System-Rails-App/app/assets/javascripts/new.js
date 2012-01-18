$(document).ready(function() {	
	
	//send
	$("#send").click(function() {
		$.post("/actions/sendnotis.json",{user_id:$("#user").attr("value"), title:$("#title").attr("value"), content:$("#content").val()}, 
			function(data) {
				if (data.status == "success") { 
					alert("Successful:"+data.message);
				} else {
					alert("Error:"+data.message);
				};
		},"json");
	});
    
});//Close Function
