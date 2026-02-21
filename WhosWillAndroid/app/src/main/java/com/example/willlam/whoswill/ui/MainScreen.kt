package com.example.willlam.whoswill.ui

import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Email
import androidx.compose.material.icons.filled.Folder
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.Icon
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import com.example.willlam.whoswill.ui.screens.ContactScreen
import com.example.willlam.whoswill.ui.screens.HomeScreen
import com.example.willlam.whoswill.ui.screens.ProjectsScreen
import com.example.willlam.whoswill.ui.screens.SkillsScreen

@Composable
fun MainScreen(viewModel: AppViewModel) {
    val translations by viewModel.translations.collectAsState()
    val t = translations ?: viewModel.t
    var selectedTab by remember { mutableStateOf(0) }

    Scaffold(
        bottomBar = {
            NavigationBar {
                listOf(
                    TabItem(0, t.nav.home, Icons.Default.Home),
                    TabItem(1, t.nav.skills, Icons.Default.Person),
                    TabItem(2, t.nav.projects, Icons.Default.Folder),
                    TabItem(3, t.nav.contact, Icons.Default.Email)
                ).forEachIndexed { index, item ->
                    NavigationBarItem(
                        selected = selectedTab == index,
                        onClick = { selectedTab = index },
                        icon = { Icon(item.icon, contentDescription = item.label) },
                        label = { Text(item.label) }
                    )
                }
            }
        }
    ) { padding ->
        when (selectedTab) {
            0 -> HomeScreen(
                modifier = Modifier.padding(padding),
                viewModel = viewModel,
                onNavigateToProjects = { selectedTab = 2 }
            )
            1 -> SkillsScreen(modifier = Modifier.padding(padding), viewModel = viewModel)
            2 -> ProjectsScreen(modifier = Modifier.padding(padding), viewModel = viewModel)
            3 -> ContactScreen(modifier = Modifier.padding(padding), viewModel = viewModel)
        }
    }
}

private data class TabItem(val index: Int, val label: String, val icon: ImageVector)
