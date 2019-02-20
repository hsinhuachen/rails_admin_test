// This file may be used for providing additional customizations to the Trestle
// admin. It will be automatically included within all admin pages.
//
// For organizational purposes, you may wish to define your customizations
// within individual partials and `require` them here.
//
//  e.g. //= require "trestle/custom/my_custom_js"

$(function(){
	var preview = $(".upload-preview img");
	var target = $("#project_gallery_list");

	// $("#project_gallery").change(function(event){
 //       var input = $(event.currentTarget);
 //       var len = input[0].files.length;
 //       var j = 0;

 //       for (var i = 0; i < len; i++) {
	// 		var file = input[0].files[i];

	// 		var reader = new FileReader();
	// 		reader.onload = function(e){
	// 			var curPhotos = target.val();
	// 			var photoName = input[0].files[j].name;

	// 			if(curPhotos != " "){
	// 				curPhotos = curPhotos + ", " + photoName;
	// 			}else{
	// 				curPhotos = photoName;
	// 			}
	// 			target.val(curPhotos);

	// 			// preview photo
	// 		   	image_base64 = e.target.result;

	// 		    if(j == 0){
	// 		   		preview.attr("src", image_base64);
	// 		    }else{
	// 		   		preview.after('<img src="' + image_base64 + '" />')
	// 		    }

	// 		    j++
	// 		};
	// 		reader.readAsDataURL(file);
	// 	} // end for
 //    });

	$(document).on("click", ".delImg", function(){
		var getId = $(this).data("id")
		var curStr = $("#project_delImg").val();

		$(this).parents(".row").fadeOut(300);

		if(curStr == ""){
			curStr = getId;
		}else{
			curStr = curStr + "," + getId;
		}

		$("#project_delImg").val(curStr);

		event.preventDefault();
	})
})