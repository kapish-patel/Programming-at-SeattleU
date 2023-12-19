/**
 * this file app.js contains javascript logic for creating updating and rendering grid
 * there are some variables which are used for creation of grid.
 * the idea is to create a empty array using a for loop
 * use of setinterval to set a update interval and render interval.
 */
const CELL_SIZE = 16;

class Helper{
    
    static playSquareWave() {
        const audioContext = new (window.AudioContext || window.webkitAudioContext)();
        const duration = 0.1; // Duration of the square wave sound in seconds
        const minFrequency = 220; // Minimum frequency in Hz
        const maxFrequency = 880; // Maximum frequency in Hz

        // Generate a random frequency within the specified range
        const frequency = Math.random() * (maxFrequency - minFrequency) + minFrequency;

        const oscillator = audioContext.createOscillator();
        oscillator.type = 'square';
        oscillator.frequency.setValueAtTime(frequency, audioContext.currentTime); // Set random frequency
        oscillator.connect(audioContext.destination); // Connect oscillator to speakers

        // Start and stop the oscillator to create a short sound
        oscillator.start();
        oscillator.stop(audioContext.currentTime + duration);
    }   

    // static function to set rows and cols
    static set_Rows_Cols(){
        //get the url and query string
        const url = window.location.href;
        const queryurl = new URL(url)
    
        let grid_rows = parseInt(queryurl.searchParams.get('height'));
        let grid_columns = parseInt(queryurl.searchParams.get('width'));
        
        //calculate max columns and rows current screen can support 
        const max_width = window.screen.width;
        const max_height = window.screen.height;
    
        const max_columns = Math.floor((max_width/1.07) / CELL_SIZE);
        const max_rows = Math.floor((max_height/1.5) / CELL_SIZE);
    
        if(isNaN(grid_rows))
            grid_rows = max_rows;
        if(isNaN(grid_columns))
            grid_columns = max_columns;
        
        return {grid_columns, grid_rows};
    }

    static updateURLParams(height, width){
        const urlParams = new URLSearchParams(window.location.search);

        // Fetch current height and width values from URL parameters
        const currentHeight = urlParams.get('height');
        const currentWidth = urlParams.get('width');

        // Update height and width parameters with new values
        urlParams.set('height', height !== undefined ? height : currentHeight);
        urlParams.set('width', width !== undefined ? width : currentWidth);

        const newUrl = `${window.location.origin}${window.location.pathname}?${urlParams.toString()}`;
        window.history.pushState({}, '', newUrl);
    }
}

//class grid manager to manage all the grid interaction
class GridManager{
    constructor(){
        const row_col =  Helper.set_Rows_Cols();
        this.gridCols = parseInt(row_col.grid_columns);
        this.gridRows = parseInt(row_col.grid_rows);
        this.cellSize = CELL_SIZE;
        this.gridContainer = document.getElementById('gridcontainer');
        this.initiategrid();
        this.grid = this.createEmptyGrid();
        this.drawGrid();
        this.isrunning = false;
    }

    // function to create a empty grid and all the cells are dead
    createEmptyGrid(){
        const grid = [];
        for(let i = 0; i < this.gridRows; i++){
            const row = [];
            for(let j = 0; j < this.gridCols; j++){
                row.push(false);
            }
            grid.push(row);
        }
        return grid
    }

    //function to initialize the grid
    initiategrid(){
        this.gridContainer.style.display = 'grid';
        this.gridContainer.style.gridTemplateColumns = `repeat(${this.gridCols}, ${this.cellSize}px)`;
        this.gridContainer.style.gridTemplateRows = `repeat(${this.gridRows}, ${this.cellSize}px)`;
    }

    // function to start the grid updates and set the running flag
    startGridUpdates(){
        this.isrunning = true;
        this.updateGrid()
    }

    // function to stop / pause game
    stopGridUpdates(){
        this.isrunning = false;
    }

    //function to reset the grid
    resetGridUpdates(){
        this.grid = this.createEmptyGrid();
        this.drawGrid();
        this.stopGridUpdates();
    }

    //function to update the grid
    updateGrid(){
        if(!this.isrunning)
            return;

        const new_grid = this.createEmptyGrid();

        for(let i = 0; i < this.gridRows; i++){
            for(let j = 0; j < this.gridCols; j++){
                const live_Neignbours = this.live_Neignbours(i,j); //get live neighbours
        
                if (this.grid[i][j]) //if alive
                    if(live_Neignbours === 2 || live_Neignbours === 3)
                        new_grid[i][j] = true;
                    else
                        new_grid[i][j] = false
                else //if dead
                    if(live_Neignbours === 3)
                        new_grid[i][j] = true;
                    else
                        new_grid[i][j] = false
            }
        }

        this.grid = new_grid;
        this.drawGrid();

        Helper.playSquareWave();

        setTimeout(() => {
            this.updateGrid();
        },1000);
    }

    //function to count the live cells around a particular cell
    live_Neignbours(row, col){
        const possible_neighbors = [
            [-1, -1], [-1, 0], [-1, 1],
            [0, -1],           [0, 1],     //center is the current element and all the 8 possible neighbours
            [1, -1], [1, 0], [1, 1]
        ];

        let counter = 0;

        for(const [dx, dy] of possible_neighbors){
            const newrow = row + dx;
            const newcol = col + dy;

            if (newrow >= 0 && newrow < this.gridRows && newcol >= 0 && newcol < this.gridCols) {

                if (this.grid[newrow][newcol])
                    counter ++;
            }
        }

        return counter
    }

    //function to display grid on canvas
    drawGrid(){
        this.gridContainer.innerHTML = '';
        
        for (let i = 0; i < this.gridRows; i++ ){
            for(let j = 0; j < this.gridCols; j++){
                const cell = document.createElement('div');
                cell.className = this.grid[i][j] ? 'grid-cell-alive' : 'grid-cell-dead';
                
                // make a new attribute so that we can store the coordinates of cell
                cell.setAttribute('data-row',i);
                cell.setAttribute('data-col',j)

                cell.addEventListener('click',() => this.toogleCell(i,j));
                this.gridContainer.appendChild(cell);
            }
        }
    }

    //function to toogle the cell from dead to alive and vise versa
    toogleCell(i,j){
        this.grid[i][j] = !this.grid[i][j]; //switch state 
        this.drawGrid();
    }
}

let grid = new GridManager();

const submit_btn = document.getElementById('submit-btn');
const start_btn = document.getElementById('start-btn');
const stop_btn = document.getElementById('stop-btn');
const reset_btn = document.getElementById('reset-btn');
const height_txtbox = document.getElementById('height-input');
const width_txtbox = document.getElementById('width-input');


//event listner for submit button
submit_btn.addEventListener('click', (event) => {
    // prevent default action so that the page does not refresh
    event.preventDefault(); 
    
    // height and width from the textbox
    const height = height_txtbox.value;
    const width = width_txtbox.value;
    
    if(!grid.isrunning){
        //validation of form input 
        if(!isNaN(height) && !isNaN(width)){
            Helper.updateURLParams(height,width);
            grid = new GridManager();
        }
    }
})
//event listner for start button
start_btn.addEventListener('click', (event) => {
    grid.startGridUpdates();
});

//event listner for stop button
stop_btn.addEventListener('click', () => {
    grid.stopGridUpdates();
});

//event listner for reset button
reset_btn.addEventListener('click', () => {
    grid.resetGridUpdates();
});

//event listner for cell updates if the grid is not working only
grid.gridContainer.addEventListener('click', (event) => {
    if(grid.isrunning){

        //get the data from the attribute that we stored see drawgrid function 
        const cell = event.target;
        const row = parseInt(cell.getAttribute('data-row'));
        const col = parseInt(cell.getAttribute('data-col'));

        //toogle the cell 
        grid.toogleCell(row, col);
    }
})