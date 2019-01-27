$(document).ready(function() {
    createDivs(16);
    clearCanvas();
    changeColor();
    changeGridSize();
});

// creates the 16 divs to use as squares
function createDivs(gridDimension) {
    $(".container").children().remove();
    $(".container").append("<table>");
    for(i=0; i< gridDimension; i++) {
        $(".container").append("<tr>");
        for(j=0; j < gridDimension; j++) {
            $(".container").append("<td></td>")
            $("td").css("height", 800/gridDimension);
            $("td").css("width", 800/gridDimension);
        }
        $(".container").append("</tr>");
    }
    $(".container").append("</table>");
    drawOnCanvas(getColor());
    paintOdin();
};

// allows user to draw on canvas
function drawOnCanvas(color) {
    $("td").hover(function() {
        $(this).css("background-image", "none");
        $(this).css("background-color", color);
    });
};

// clears canvas when "Clear" button is clicked
function clearCanvas() {
    $("#clear").click(function() {
        $("td").css("background-color", "white");
        $("td").css("background-image", "none");
    });
};

// changes the dimensions of grid by asking user for new size, only allows numbers
function changeGridSize() {
    $("#gridSize").click(function() {
        var userDimension = prompt("Enter the grid size (i.e. enter 10 for a 10x10 grid)")
        while (isNaN(userDimension) === true) {
            userDimension = prompt("Please enter a number for the grid size.");
        }
        createDivs(userDimension);
    });
};

function getColor() {
    return $('#chooseColor').val();
}

// allows user to select color to draw with
function changeColor() {
    $('select').on('change', function() {
        var color = this.value;
        drawOnCanvas(color);
    }); 
};

// allows user to use the odin logo as their paintbrush
function paintOdin() {
    $('#odin').click(function() {
        $("td").hover(function() {
            $(this).css("background-color", "none");
            $(this).css("background-image", 'url("images/odinLogo.jpeg")');
            $(this).css("background-size", "100% 100%");
        });
    });
};