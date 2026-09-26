"""Minimal hello node — complete the TODOs."""
from __future__ import annotations

import rclpy
from rclpy.node import Node


class HelloNode(Node):
    def __init__(self) -> None:
        # === STUDENT TODO ===
        # Call super().__init__ with a unique node name, e.g. "hello_onboarding".
        # Create a 1.0 s timer that calls self._tick.
        super().__init__("hello_onboarding")
        self.create_timer(1.0, self._tick)
        # === END TODO ===

    def _tick(self) -> None:
        # === STUDENT TODO ===
        # Log an info message with self.get_logger().info(...)
        self.get_logger().info("Exercise 1 from Onboarding")
        # === END TODO ===


def main() -> None:
    rclpy.init()
    node = HelloNode()
    try:
        rclpy.spin(node)
    finally:
        node.destroy_node()
        rclpy.shutdown()


if __name__ == "__main__":
    main()
