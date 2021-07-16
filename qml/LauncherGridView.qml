import QtQuick 2.0
import org.heera.launcher 1.0

PagedGrid {
    id: gridView

    property int cellHeight: Math.max(144, gridView.height * 0.21)
    property int cellWidth: Math.max(144, gridView.height * 0.21)

    columns: gridView.width / cellWidth
    rows: gridView.height / cellHeight

    model: launcherModel

    delegate: Item {
        width: cellWidth
        height: cellHeight

        LauncherGridDelegate {
            id: delegate

            anchors {
                fill: parent
                margins: 10
            }
        }
    }

    onWidthChanged: {
        gridView.adaptGrid()
    }

    onHeightChanged: {
        gridView.adaptGrid()
    }

    function calcExtraSpacing(cellSize, containerSize) {
        var availableColumns = Math.floor(containerSize / cellSize);
        var extraSpacing = 0;
        if (availableColumns > 0) {
            var allColumnSize = availableColumns * cellSize;
            var extraSpace = Math.max(containerSize - allColumnSize, 0);
            extraSpacing = extraSpace / availableColumns;
        }
        return Math.floor(extraSpacing);
    }

    function adaptGrid() {
        var fullWidth = gridView.width
        var fullHeight = gridView.height

        var cellSize = Math.max(144, gridView.height * 0.21)

        gridView.cellWidth = cellSize + calcExtraSpacing(cellSize, fullWidth)
        gridView.cellHeight = cellSize + calcExtraSpacing(cellSize, fullHeight)
    }
}
