<template>
	<Teleport to="body">
		<div class="dialog-backdrop" @click.self="$emit('close')">
			<div :class="`dialog-wrap`">
				<slot>
					<ui-svg-icon name="cross" :size="12" @click="$emit('close')" />
					<p class="dialog-title">{{ title }}</p>
					<div class="dialog-btn-group">
						<ui-btn @click="$emit('clickFirstBtn')"> {{ firstBtnText }} </ui-btn>
						<ui-btn  v-if="secondBtnText" type="secondary" @click="$emit('clickSecondBtn')"> {{ secondBtnText }} </ui-btn>
					</div>
				</slot>
			</div>
		</div>
	</Teleport>
</template>

<script setup lang="ts">
	defineEmits(['close', 'clickFirstBtn', 'clickSecondBtn'])

	defineProps({
		title: { type: String, required: true },
		firstBtnText: { type: String, default: 'Да' },
		secondBtnText: { type: String, default: '' },
	})

	const addBodyClass = (className: string) => {
		if (document && document.body) {
			document.body.classList.add(className)
		}
	}

	const removeBodyClass = (className: string) => {
		if (document && document.body) {
			document.body.classList.remove(className)
		}
	}

	onMounted(() => {
		addBodyClass('overflow-hidden')
	})

	onUnmounted(() => {
		removeBodyClass('overflow-hidden')
	})
</script>

<style lang="scss" scoped>
	.dialog {
		&-backdrop {
			position: fixed;
			left: 0;
			bottom: 0;
			background: $color-dialog-backdrop;
			width: 100%;
			height: 100%;
			z-index: 999;
			display: flex;
			justify-content: center;
			align-items: center;
		}
		&-wrap {
			border-radius: 24px;
			padding: 24px;
			max-width: 320px;
			width: 100%;
			background-color: $color-white;
			position: relative;
			& svg {
				position: absolute;
				right: 16px;
				top: 12px;
				display: block;
				color: $color-primary;
				cursor: pointer;
				transition: $transition-color;
				&:hover {
					color: $color-primary--hover;
				}
				&:active {
					color: $color-primary--active;
				}
			}
		}
		&-title {
			@include font-18-semibold;
			color: $color-text;
			margin-bottom: 24px;
			text-align: center;
		}
		&-btn-group {
			display: flex;
			justify-content: center;
			& .btn {
				min-width: 96px;
			}
			& > *:first-child {
				margin-right: 8px;
			}
		}
	}
</style>

