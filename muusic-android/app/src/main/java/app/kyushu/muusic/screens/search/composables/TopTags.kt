package app.kyushu.muusic.screens.search.composables

import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyHorizontalGrid
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.TextUnitType
import androidx.compose.ui.unit.dp
import app.kyushu.muusic.data.remote.muusicBackend.responses.TagDetails
import coil.compose.AsyncImage

@Composable
fun TopTags(tags: List<TagDetails>, modifier: Modifier = Modifier) {
    Column(
        modifier = modifier
            .fillMaxWidth()
            .height(200.dp),
    ) {
        Text(
            text = "Your Top Tags",
            style = MaterialTheme.typography.titleMedium.copy(
                fontSize = TextUnit(20f, TextUnitType.Sp),
                fontWeight = FontWeight(700),
            )
        )
        Spacer(modifier = Modifier.height(16.dp))
        LazyHorizontalGrid(
            rows = GridCells.Fixed(2),
            verticalArrangement = Arrangement.spacedBy(8.dp),
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            content = {
                items(4) { _ ->
                    TagItem(tag = tags[0])
                }
            },
            modifier = Modifier.fillMaxWidth(),
        )
    }
}

@Composable
fun TagItem(tag: TagDetails, modifier: Modifier = Modifier) {
    val infiniteTransition = rememberInfiniteTransition(label = "")
    val offset: Float by infiniteTransition.animateFloat(
        initialValue = 0f,
        targetValue = 7.5f,
        animationSpec = infiniteRepeatable(
            tween(1500, easing = FastOutSlowInEasing),
            repeatMode = RepeatMode.Reverse,
        ), label = ""
    )
        val brush = Brush.linearGradient(
        start = Offset(offset * 100 - 1000, offset * 10),
        end = Offset(offset * 100 + 1000, offset * 10 + 500),
        colors = listOf(
            Color.Transparent,
            MaterialTheme.colorScheme.surface.copy(alpha = 0.5f),
            Color.Transparent,
        )
    )

    Box(
        modifier = modifier
            .width(LocalConfiguration.current.screenWidthDp.dp / 2 - 16.dp)
            .height(100.dp)
            .clip(MaterialTheme.shapes.medium)
            .background(
                color = MaterialTheme.colorScheme.surface,
                shape = MaterialTheme.shapes.medium,
            )
    ) {
        AsyncImage(
            model = tag.imageUrl,
            contentDescription = "Hip Hop Tag Image",
            contentScale = ContentScale.Crop,
            alpha = 0.5f,
            modifier = Modifier.fillMaxSize(),
        )
        Column(
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier
                .width(LocalConfiguration.current.screenWidthDp.dp / 2 - 16.dp)
                .height(100.dp)
                .background(
                    brush = brush,
                )
        ) {
            Text(
                text = tag.name,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis,
                style = MaterialTheme.typography.bodyMedium.copy(
                    fontSize = TextUnit(16f, TextUnitType.Sp),
                    fontWeight = FontWeight(600),
                )
            )
        }
    }
}