package app.kyushu.muusic.screens.search.composables

import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyHorizontalGrid
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
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
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.TextUnitType
import androidx.compose.ui.unit.dp
import app.kyushu.muusic.data.remote.muusicBackend.responses.Album
import app.kyushu.muusic.data.remote.muusicBackend.responses.Artist
import app.kyushu.muusic.data.remote.muusicBackend.responses.Track
import coil.compose.AsyncImage

@Composable
fun RecentlyPlayedItems(items: List<Any>, modifier: Modifier = Modifier) {
    Column(
        modifier = modifier
            .fillMaxWidth(),
    ) {
        Text(
            text = "Recently Played",
            style = MaterialTheme.typography.titleMedium.copy(
                fontSize = TextUnit(20f, TextUnitType.Sp),
                fontWeight = FontWeight(700),
            )
        )
        Spacer(modifier = Modifier.height(16.dp))
        Column(
            verticalArrangement = Arrangement.spacedBy(8.dp),
            content = {
                for (item in items) {
                    RecentlyPlayedItemsItem(item = item)
                }
            },
            modifier = Modifier.fillMaxWidth(),
        )
    }
}

@Composable
fun RecentlyPlayedItemsItem(item: Any, modifier: Modifier = Modifier) {
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
        start = Offset(offset * 300 - 1000, offset * 10),
        end = Offset(offset * 300 + 100, offset * 10 + 500),
        colors = listOf(
            Color.Transparent,
            MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f),
            Color.Transparent,
        )
    )

    Surface(
        color = MaterialTheme.colorScheme.surface,
        modifier = modifier
            .height(100.dp)
            .fillMaxWidth()
            .clip(MaterialTheme.shapes.medium),
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier
                .fillMaxSize()
                .clip(MaterialTheme.shapes.medium)
                .background(
                    brush = brush,
                ),
        ) {
            when (item) {
                is Artist -> {
                    AsyncImage(
                        model = item.imageUrl,
                        contentDescription = item.name,
                        contentScale = ContentScale.Crop,
                        modifier = Modifier
                            .aspectRatio(1f)
                    )
                    Column(
                        verticalArrangement = Arrangement.Center,
                        modifier = Modifier.padding(16.dp)
                    ) {
                        Text(
                            text = item.name,
                            maxLines = 2,
                            overflow = TextOverflow.Ellipsis,
                            style = MaterialTheme.typography.bodyLarge.copy(
                                fontSize = TextUnit(20f, TextUnitType.Sp),
                                fontWeight = FontWeight(800),
                            ),
                        )
                    }
                }
                is Album -> {
                    AsyncImage(
                        model = item.imageUrl,
                        contentDescription = item.name,
                        contentScale = ContentScale.Crop,
                        modifier = Modifier
                            .aspectRatio(1f)
                    )
                    Column(
                        verticalArrangement = Arrangement.Center,
                        modifier = Modifier.padding(16.dp)
                    ) {
                        Text(
                            text = item.name,
                            maxLines = 2,
                            overflow = TextOverflow.Ellipsis,
                            style = MaterialTheme.typography.bodyLarge.copy(
                                fontSize = TextUnit(20f, TextUnitType.Sp),
                                fontWeight = FontWeight(800),
                            ),
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        Text(
                            text = item.artistName,
                            style = MaterialTheme.typography.bodyMedium.copy(
                                fontSize = TextUnit(16f, TextUnitType.Sp),
                                fontWeight = FontWeight(600),
                            ),
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        if (item.numberOfTracks != null)
                        Text(
                            text = "${item.numberOfTracks} tracks",
                            style = MaterialTheme.typography.bodyMedium.copy(
                                fontSize = TextUnit(14f, TextUnitType.Sp),
                                fontWeight = FontWeight(500),
                            ),
                        )
                    }
                }
                is Track -> {
                    AsyncImage(
                        model = item.imageUrl,
                        contentDescription = item.name,
                        contentScale = ContentScale.Crop,
                        modifier = Modifier
                            .aspectRatio(1f)
                    )
                    Column(
                        verticalArrangement = Arrangement.Center,
                        modifier = Modifier.padding(16.dp)
                    ) {
                        Text(
                            text = item.name,
                            maxLines = 2,
                            overflow = TextOverflow.Ellipsis,
                            style = MaterialTheme.typography.bodyLarge.copy(
                                fontSize = TextUnit(20f, TextUnitType.Sp),
                                fontWeight = FontWeight(800),
                            ),
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        Text(
                            text = item.artistName,
                            style = MaterialTheme.typography.bodyMedium.copy(
                                fontSize = TextUnit(16f, TextUnitType.Sp),
                                fontWeight = FontWeight(600),
                            ),
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        if (item.albumName != null)
                        Text(
                            text = item.albumName,
                            style = MaterialTheme.typography.bodyMedium.copy(
                                fontSize = TextUnit(14f, TextUnitType.Sp),
                                fontWeight = FontWeight(500),
                            ),
                        )
                    }
                }
            }
        }
    }
}