package com.example.willlam.whoswill.ui.screens

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import androidx.compose.ui.window.DialogProperties
import com.example.willlam.whoswill.data.Project
import com.example.willlam.whoswill.ui.AppViewModel
import com.example.willlam.whoswill.ui.components.LanguagePicker
import com.example.willlam.whoswill.ui.components.ProjectCard
import com.example.willlam.whoswill.ui.components.ProjectDetailSheet
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text

@Composable
fun ProjectsScreen(
    modifier: Modifier = Modifier,
    viewModel: AppViewModel
) {
    val translations by viewModel.translations.collectAsState()
    val t = translations ?: viewModel.t
    val projects = viewModel.projects()
    var selectedProject by remember { mutableStateOf<Project?>(null) }
    val scrollState = rememberScrollState()

    Column(modifier = modifier.fillMaxSize()) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp, vertical = 8.dp),
            horizontalArrangement = Arrangement.End
        ) {
            LanguagePicker(
                currentLocale = viewModel.locale.value,
                onLocaleSelected = { viewModel.setLocale(it) }
            )
        }
        Column(
            modifier = Modifier
                .verticalScroll(scrollState)
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            Column(verticalArrangement = Arrangement.spacedBy(6.dp)) {
                Text(
                    text = t.projects.portfolio,
                    style = MaterialTheme.typography.labelMedium,
                    color = MaterialTheme.colorScheme.primary
                )
                Text(
                    text = t.projects.title,
                    style = MaterialTheme.typography.titleLarge,
                    color = MaterialTheme.colorScheme.onSurface
                )
                Text(
                    text = t.common.moreProjectsLater,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
            projects.forEach { project ->
                ProjectCard(
                    project = project,
                    viewDetailsLabel = t.common.viewDetails,
                    visitProjectLabel = t.common.visitProject,
                    onViewDetails = { selectedProject = project }
                )
            }
        }
    }

    selectedProject?.let { project ->
        Dialog(
            onDismissRequest = { selectedProject = null },
            properties = DialogProperties(usePlatformDefaultWidth = false)
        ) {
            ProjectDetailSheet(
                project = project,
                featuresLabel = t.common.featuresSection,
                awardsLabel = t.common.awardsSection,
                visitProjectLabel = t.common.visitProject,
                closeLabel = t.common.close,
                onDismiss = { selectedProject = null }
            )
        }
    }
}
