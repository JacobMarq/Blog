//dropdown menu variables

const dropDownHamburger = document.querySelector('ham');
dropDownHamburger.addEventListener('click', function(){ToggleDropDown();});
// const dropDownMenu = document.getElementById('dialog-container');
const DialogBox = document.querySelector('explore-blog');
let isDropDownActive = false;

//dropdown menu function

function ToggleDropDown()
{
    if(!isDropDownActive)
    {   
        setTimeout(ShowDropdownMenu, 5);
    }
    else
    {
        dropDownHamburger.classList.add('collapsed');
        isDropDownActive = false
        setTimeout(HideDropdownMenu, 250);
    }
}
function ShowDropdownMenu()
{
    dropDownHamburger.classList.remove('collapsed');
    dropDownHamburger.attr(ariaExpanded, 'true')
    DialogBox.classList.add('show');
    isDropDownActive = true
}
function HideDropdownMenu()
{
    dropDownHamburger.attr(ariaExpanded, 'false')
    DialogBox.classList.remove('show');
}