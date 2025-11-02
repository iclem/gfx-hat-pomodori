
import os
import sys
def pytest_configure():
    os.environ['GPIOZERO_PIN_FACTORY'] = 'mock'

from unittest import mock
import pytest




@pytest.fixture(scope='session', autouse=True)
def spidev():
    """Mock spidev module."""
    spidev = mock.MagicMock()
    sys.modules['spidev'] = spidev
    return spidev


@pytest.fixture(scope='session', autouse=True)
def cap1xxx():
    """Mock cap1xxx module."""
    cap1xxx = mock.MagicMock()
    sys.modules['cap1xxx'] = cap1xxx
    return cap1xxx


@pytest.fixture(scope='session', autouse=True)
def sn3218():
    """Mock sn3218 module."""
    sn3218 = mock.MagicMock()
    sys.modules['sn3218'] = sn3218
    return sn3218
